# RV32I Processor — Computer Architecture & Organization (401331)

Team RISC-V · Fall 2026/2027 · Project weight: 20% of course grade

**Team:** Mohammad Shabib · Raad Hammad

Design, implementation (Verilog), and verification of a 32-bit RISC-V (RV32I
base subset) processor, culminating in benchmark execution and performance
analysis. See `docs/Phase1_Proposal.docx` for the architectural plan and
`docs/ISA_Spec.docx` for the complete instruction set specification.

## Repository layout

```
riscv-cpu/
├── docs/                 # Phase deliverables (proposal, ISA spec, reports)
│   ├── Phase1_Proposal.docx
│   └── ISA_Spec.docx
├── sim/                  # Verilog source + testbenches
│   ├── top.v             # Processor top module (Phase 1: PC skeleton)
│   └── tb_phase1.v       # Self-checking Phase 1 smoke testbench
└── asm/                  # RISC-V assembly test programs (RARS)
    └── smoke.s           # Phase 1 toolchain smoke test
```

## Toolchain setup (Ubuntu/Debian)

```bash
sudo apt install -y iverilog      # Icarus Verilog (simulation)
sudo apt install -y default-jre   # Java runtime, for RARS
# RARS (golden reference simulator): download from https://github.com/TheThirdOne/rars/releases
```

## How to run

**Verilog smoke test (Phase 1 environment check):**

```bash
iverilog -o tb_phase1 sim/tb_phase1.v sim/top.v && vvp tb_phase1
# Expected last line: PHASE1 SMOKE TEST: ALL TESTS PASSED
```

**RARS assembly smoke test:**

```bash
java -jar rars.jar asm/smoke.s
# Expected console output: 42 (newline) — computed as (6 << 3) - 6
```

## Phase roadmap

| Phase | Due | Status | Deliverables |
|-------|-----|--------|--------------|
| 1 — Spec & setup | Wk 4 | **this repo** | Proposal, ISA spec, testbench, toolchain |
| 2 — Datapath | Wk 7 | — | ALU, register file, control unit, single-cycle datapath |
| 3 — Cache & pipeline | Wk 10 | — | Direct-mapped cache, 5-stage pipeline, hazard/forwarding |
| 4 — Benchmarks & defense | Wk 13 | — | Sort/Fib/matrix-mul runs, CPI & miss-rate analysis, IEEE report, demo video |

Oral defense: Week 14.
