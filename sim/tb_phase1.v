// tb_phase1.v — Phase 1 self-checking smoke testbench.
//
// Verifies the Phase 1 skeleton: synchronous reset drives PC to 0, and the
// PC then advances sequentially (0, 4, 8, ...). Run with Icarus Verilog:
//
//     iverilog -o tb_phase1 sim/tb_phase1.v sim/top.v && vvp tb_phase1
//
// Expected final line: "PHASE1 SMOKE TEST: ALL TESTS PASSED"

`timescale 1ns/1ps

module tb_phase1;

    reg         clk = 1'b0;
    reg         rst = 1'b1;
    wire [31:0] pc;

    top dut (
        .clk (clk),
        .rst (rst),
        .pc  (pc)
    );

    // 100 MHz clock: 10 ns period
    always #5 clk = ~clk;

    integer errors = 0;
    integer i;

    // Compact check helper
    task check_pc(input [31:0] expected, input [8*24-1:0] label);
        begin
            if (pc !== expected) begin
                errors = errors + 1;
                $display("FAIL [%0s]: pc=%0d, expected %0d", label, pc, expected);
            end
        end
    endtask

    initial begin
        // ---- Reset phase ---------------------------------------------------
        // Hold reset across 3 rising edges; PC must stay 0.
        repeat (3) @(posedge clk);
        #1 check_pc(32'h0000_0000, "reset hold");

        // Release reset between edges (non-blocking, settled before next edge)
        rst <= 1'b0;

        // ---- Sequential fetch check ----------------------------------------
        // After reset release, PC must walk 4, 8, 12, 16, 20 on successive edges.
        for (i = 1; i <= 5; i = i + 1) begin
            @(posedge clk);
            #1 check_pc(i * 32'd4, "sequential pc");
        end

        // ---- Verdict ---------------------------------------------------------
        if (errors == 0)
            $display("PHASE1 SMOKE TEST: ALL TESTS PASSED");
        else
            $display("PHASE1 SMOKE TEST: %0d FAILURE(S)", errors);
        $finish;
    end

endmodule
