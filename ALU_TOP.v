module ALU_TOP #(parameter Op_Width = 16)(
    input [Op_Width - 1: 0] A, B,
    input [3 : 0] ALU_FUN,
    input CLK, RST,
    output Carry_OUT,
    output [Op_Width - 1: 0] Arith_OUT, Logic_OUT, CMP_OUT, Shift_OUT,
    output Arith_FLAG, Logic_FLAG, CMP_FLAG, Shift_FLAG
);

wire Arith_EN, Logic_EN, CMP_EN, Shift_EN;

ALU_Decoder M0(
    .ALU_FUN(ALU_FUN[3:2]),
    .Arith_En(Arith_EN),
    .Logic_En(Logic_EN),
    .CMP_En(CMP_EN),
    .Shift_En(Shift_EN)
);

ALU_Arith_Unit #(.Op_Width(Op_Width)) M1(
    .A(A),
    .B(B),
    .ALU_FUN(ALU_FUN[1:0]),
    .CLK(CLK),
    .RST(RST),
    .Arith_En(Arith_EN),
    .Arith_Out(Arith_OUT),
    .Carry_Out(Carry_OUT),
    .Arith_Flag(Arith_FLAG)
);

ALU_Logic_Unit #(.Op_Width(Op_Width)) M2(
    .A(A),
    .B(B),
    .ALU_FUN(ALU_FUN[1:0]),
    .CLK(CLK),
    .RST(RST),
    .Logic_En(Logic_EN),
    .Logic_Out(Logic_OUT),
    .Logic_Flag(Logic_FLAG)
);

ALU_CMP_Unit #(.Op_Width(Op_Width)) M3(
    .A(A),
    .B(B),
    .ALU_FUN(ALU_FUN[1:0]),
    .CLK(CLK),
    .RST(RST),
    .CMP_En(CMP_EN),
    .CMP_Out(CMP_OUT),
    .CMP_Flag(CMP_FLAG)
);

ALU_Shift_Unit #(.Op_Width(Op_Width)) M4(
    .A(A),
    .B(B),
    .ALU_FUN(ALU_FUN[1:0]),
    .CLK(CLK),
    .RST(RST),
    .Shift_En(Shift_EN),
    .Shift_Out(Shift_OUT),
    .Shift_Flag(Shift_FLAG)
);
endmodule