`timescale 1ps / 1ps

`define MRF_0_MEMORY_INST ma_ddr4fake_wrapper_inst.ma_ddr4fake_i.mrf_0.inst.native_mem_module.blk_mem_gen_v8_4_8_inst.memory
`define MRF_0_DUMP_FILE "dump_mrf_0.txt"
parameter MRF_DATAWIDTH = 1024;
parameter MRF_DEPTH = 64;

`define VRF_MEMORY_INST ma_ddr4fake_wrapper_inst.ma_ddr4fake_i.vrf.inst.native_mem_module.blk_mem_gen_v8_4_8_inst.memory
`define VRF_DUMP_FILE "dump_vrf.txt"
parameter VRF_DATAWIDTH = 1024;
parameter VRF_DEPTH = 1024;

module sim_tb;

  // Parameter declarations
  parameter CLK_PERIOD = 5000;  // 5ns (200 MHz)
  parameter DDR4_CLK_PERIOD = 3332;  // 3.332ns (~300 MHz)

  // Signals
  logic        clk;
  logic        rst_n;
  logic        c0_ddr4_ui_clk;
  logic        c0_ddr4_ui_clk_sync_rst;

  // MRF_0 Interface Signals
  logic        mrf0_ld_start_i;
  logic [35:0] mrf0_ld_src_axi_addr_i;
  logic [ 5:0] mrf0_ld_dst_bram_addr_i;
  logic [14:0] mrf0_ld_byte_to_trans_i;
  logic        mrf0_ld_done_o;

  // VRF_LD Interface Signals
  logic [14:0] vrf_ld_byte_to_trans_i;
  logic [ 9:0] vrf_ld_dst_bram_addr_i;
  logic [35:0] vrf_ld_src_axi_addr_i;
  logic        vrf_ld_start_i;
  logic        vrf_ld_full_o;

  // Clock generation
  initial begin
    clk = 0;
    forever #(CLK_PERIOD / 2) clk = ~clk;
  end

  initial begin
    c0_ddr4_ui_clk = 0;
    forever #(DDR4_CLK_PERIOD / 2) c0_ddr4_ui_clk = ~c0_ddr4_ui_clk;
  end

  // Reset sequence
  initial begin
    rst_n                   = 0;
    c0_ddr4_ui_clk_sync_rst = 1;  // Active-high reset
    #(CLK_PERIOD * 5);
    rst_n                   = 1;
    c0_ddr4_ui_clk_sync_rst = 0;
  end

  // Testbench stimulus
  initial begin
    // Initialize signals
    mrf0_ld_start_i         = 0;
    mrf0_ld_src_axi_addr_i  = 0;
    mrf0_ld_dst_bram_addr_i = 0;
    mrf0_ld_byte_to_trans_i = 0;

    vrf_ld_byte_to_trans_i  = 0;
    vrf_ld_dst_bram_addr_i  = 0;
    vrf_ld_src_axi_addr_i   = 0;
    vrf_ld_start_i          = 0;

    @(negedge c0_ddr4_ui_clk_sync_rst);
    repeat (5) @(posedge clk);

    // Test Case 1
    fork
      // MRF_0 Transaction (2048 bytes)
      begin
        @(posedge clk);
        mrf0_ld_src_axi_addr_i  = 36'h0;
        mrf0_ld_dst_bram_addr_i = 6'h48;
        mrf0_ld_byte_to_trans_i = 15'(128 * 16);  // 2048 bytes
        mrf0_ld_start_i         = 1;
        @(posedge clk);
        mrf0_ld_start_i = 0;
        @(posedge mrf0_ld_done_o);
      end
      // VRF_LD Transactions (2 x 128 bytes)
      begin
        // First VRF_LD Transaction
        @(posedge clk);
        if (!vrf_ld_full_o) begin
          vrf_ld_src_axi_addr_i  = 36'h0;
          vrf_ld_dst_bram_addr_i = 10'h0;
          vrf_ld_byte_to_trans_i = 15'(128);  // 128 bytes
          vrf_ld_start_i         = 1;
          @(posedge clk);
          vrf_ld_start_i = 0;
          @(negedge vrf_ld_full_o);
        end

        // Second VRF_LD Transaction
        @(posedge clk);
        if (!vrf_ld_full_o) begin
          vrf_ld_src_axi_addr_i  = 36'h80;  // Next 128 bytes
          vrf_ld_dst_bram_addr_i = 10'h2;  // Next BRAM address
          vrf_ld_byte_to_trans_i = 15'(128);  // 128 bytes
          vrf_ld_start_i         = 1;
          @(posedge clk);
          vrf_ld_start_i = 0;
          @(negedge vrf_ld_full_o);
        end
      end
    join

    // Test Case 2
    fork
      // MRF_0 Transaction (2048 bytes)
      begin
        @(posedge clk);
        mrf0_ld_src_axi_addr_i  = 36'hc;
        mrf0_ld_dst_bram_addr_i = 6'h32;
        mrf0_ld_byte_to_trans_i = 15'(128 * 16);  // 2048 bytes
        mrf0_ld_start_i         = 1;
        @(posedge clk);
        mrf0_ld_start_i = 0;
        @(posedge mrf0_ld_done_o);
      end
      // VRF_LD Transactions (2 x 128 bytes)
      begin
        // First VRF_LD Transaction
        @(posedge clk);
        if (!vrf_ld_full_o) begin
          vrf_ld_src_axi_addr_i  = 36'h100;
          vrf_ld_dst_bram_addr_i = 10'h4;
          vrf_ld_byte_to_trans_i = 15'(128);  // 128 bytes
          vrf_ld_start_i         = 1;
          @(posedge clk);
          vrf_ld_start_i = 0;
          @(negedge vrf_ld_full_o);
        end

        // Second VRF_LD Transaction
        @(posedge clk);
        if (!vrf_ld_full_o) begin
          vrf_ld_src_axi_addr_i  = 36'h180;
          vrf_ld_dst_bram_addr_i = 10'h6;
          vrf_ld_byte_to_trans_i = 15'(128);  // 128 bytes
          vrf_ld_start_i         = 1;
          @(posedge clk);
          vrf_ld_start_i = 0;
          @(negedge vrf_ld_full_o);
        end
      end
    join

    // Test Case 3
    fork
      // MRF_0 Transaction (2048 bytes)
      begin
        @(posedge clk);
        mrf0_ld_src_axi_addr_i  = 36'h2;
        mrf0_ld_dst_bram_addr_i = 6'h0;
        mrf0_ld_byte_to_trans_i = 15'(128 * 16);  // 2048 bytes
        mrf0_ld_start_i         = 1;
        @(posedge clk);
        mrf0_ld_start_i = 0;
        @(posedge mrf0_ld_done_o);
      end
      // VRF_LD Transactions (2 x 128 bytes)
      begin
        // First VRF_LD Transaction
        @(posedge clk);
        if (!vrf_ld_full_o) begin
          vrf_ld_src_axi_addr_i  = 36'h200;
          vrf_ld_dst_bram_addr_i = 10'h8;
          vrf_ld_byte_to_trans_i = 15'(128);  // 128 bytes
          vrf_ld_start_i         = 1;
          @(posedge clk);
          vrf_ld_start_i = 0;
          @(negedge vrf_ld_full_o);
        end

        // Second VRF_LD Transaction
        @(posedge clk);
        if (!vrf_ld_full_o) begin
          vrf_ld_src_axi_addr_i  = 36'h280;
          vrf_ld_dst_bram_addr_i = 10'ha;
          vrf_ld_byte_to_trans_i = 15'(128);  // 128 bytes
          vrf_ld_start_i         = 1;
          @(posedge clk);
          vrf_ld_start_i = 0;
          @(negedge vrf_ld_full_o);
        end
      end
    join

    // Test Case 4
    fork
      // MRF_0 Transaction (2048 bytes)
      begin
        @(posedge clk);
        mrf0_ld_src_axi_addr_i  = 36'he;
        mrf0_ld_dst_bram_addr_i = 6'h16;
        mrf0_ld_byte_to_trans_i = 15'(128 * 16);  // 2048 bytes
        mrf0_ld_start_i         = 1;
        @(posedge clk);
        mrf0_ld_start_i = 0;
        @(posedge mrf0_ld_done_o);
      end
      // VRF_LD Transactions (2 x 128 bytes)
      begin
        // First VRF_LD Transaction
        @(posedge clk);
        if (!vrf_ld_full_o) begin
          vrf_ld_src_axi_addr_i  = 36'h300;
          vrf_ld_dst_bram_addr_i = 10'hc;
          vrf_ld_byte_to_trans_i = 15'(128);  // 128 bytes
          vrf_ld_start_i         = 1;
          @(posedge clk);
          vrf_ld_start_i = 0;
          @(negedge vrf_ld_full_o);
        end

        // Second VRF_LD Transaction
        @(posedge clk);
        if (!vrf_ld_full_o) begin
          vrf_ld_src_axi_addr_i  = 36'h380;
          vrf_ld_dst_bram_addr_i = 10'he;
          vrf_ld_byte_to_trans_i = 15'(128);  // 128 bytes
          vrf_ld_start_i         = 1;
          @(posedge clk);
          vrf_ld_start_i = 0;
          @(negedge vrf_ld_full_o);
        end
      end
    join

    repeat (5) @(posedge clk);
    log_mrf(`MRF_0_DUMP_FILE, `MRF_0_MEMORY_INST);
    log_vrf(`VRF_DUMP_FILE, `VRF_MEMORY_INST);
    $finish;
  end

  // Instantiate ma_ddr4fake_wrapper
  ma_ddr4fake_wrapper ma_ddr4fake_wrapper_inst (
    .c0_ddr4_ui_clk         (c0_ddr4_ui_clk),
    .c0_ddr4_ui_clk_sync_rst(c0_ddr4_ui_clk_sync_rst),
    .clk                    (clk),
    .rst_n                  (rst_n),
    .mrf0_ld_start_i        (mrf0_ld_start_i),
    .mrf0_ld_src_axi_addr_i (mrf0_ld_src_axi_addr_i),
    .mrf0_ld_dst_bram_addr_i(mrf0_ld_dst_bram_addr_i),
    .mrf0_ld_byte_to_trans_i(mrf0_ld_byte_to_trans_i),
    .mrf0_ld_done_o         (mrf0_ld_done_o),
    .vrf_ld_full_o          (vrf_ld_full_o),
    .vrf_ld_start_i         (vrf_ld_start_i),
    .vrf_ld_src_axi_addr_i  (vrf_ld_src_axi_addr_i),
    .vrf_ld_dst_bram_addr_i (vrf_ld_dst_bram_addr_i),
    .vrf_ld_byte_to_trans_i (vrf_ld_byte_to_trans_i)
  );

  // Memory logging task for MRF
  task automatic log_mrf(string filename, input [MRF_DATAWIDTH-1:0] memory[0:MRF_DEPTH-1]);
    int dump_file = $fopen(filename, "w");
    for (int i = 0; i < MRF_DEPTH; i = i + 1) begin
      $fdisplay(dump_file, "mem[%04d]: %h", i, memory[i]);
    end
    $fclose(dump_file);
  endtask

  // Memory logging task for VRF
  task automatic log_vrf(string filename, input [VRF_DATAWIDTH-1:0] memory[0:VRF_DEPTH-1]);
    int dump_file = $fopen(filename, "w");
    for (int i = 0; i < VRF_DEPTH; i = i + 1) begin
      $fdisplay(dump_file, "mem[%04d]: %h", i, memory[i]);
    end
    $fclose(dump_file);
  endtask

endmodule
