// top.v — Phase 1 simulation skeleton for the RV32I processor project.
//
// Phase 1 goal: prove the simulation environment works end-to-end.
// This skeleton implements only the program counter so the self-checking
// testbench has real behavior to verify. The module interface below
// (clk, rst, pc) is final — Phase 2 grows the datapath inside this module.
//
// TODO Phase 2: instruction fetch from RAM, ALU, register file, control unit
// TODO Phase 3: pipeline registers (IF/ID/EX/MEM/WB), forwarding, hazard unit,
//               direct-mapped cache
// TODO Phase 4: ECALL/EBREAK simulation-stop hooks for benchmark runs

`timescale 1ns/1ps

module top (
    input  wire        clk,
    input  wire        rst,   // synchronous, active-high
    output wire [31:0] pc     // observable program counter (PC)
);

    // ---- Program counter ---------------------------------------------------
    reg  [31:0] pc_r;

    // Next-PC: currently sequential fetch only.
    // Phase 2 adds the branch/jump mux (B-format targets, JAL/JALR, PC+4).
    wire [31:0] pc_plus4 = pc_r + 32'd4;

    always @(posedge clk) begin
        if (rst)
            pc_r <= 32'h0000_0000;   // reset vector
        else
            pc_r <= pc_plus4;        // TODO Phase 2: next-pc selection
    end

    assign pc = pc_r;

endmodule
