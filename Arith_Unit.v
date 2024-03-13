module ALU_Arith_Unit #(parameter Op_Width = 16)(
    input [Op_Width - 1: 0] A, B,
    input [1 : 0] ALU_FUN,
    input CLK, RST, Arith_En,
    output reg [Op_Width - 1: 0] Arith_Out,
    output reg Carry_Out,
    output reg Arith_Flag
);

//Internal Signals
reg [Op_Width - 1: 0] Arith_Comp;
reg Carry_Out_Comp;
reg Arith_Flag_Comp;

//Local Parameters
localparam  Add =  2'b00,
            Subt = 2'b01,
            Mult = 2'b10,
            Div  = 2'b11;

// All O/P are Regstered 
always@(posedge CLK or negedge RST)
begin
    if(!RST || !Arith_En)
        begin
            Arith_Out <= 'b0;
            Carry_Out <= 1'b0;
            Arith_Flag <= 1'b0;
        end

    else
        begin
            Arith_Out <= Arith_Comp;
            Carry_Out <= Carry_Out_Comp;
            Arith_Flag <= Arith_Flag_Comp;
        end
end

always@(*)
begin
    Arith_Comp = 'b0;
    Carry_Out_Comp = 1'b0;
    Arith_Flag_Comp = 1'b0;
    case(ALU_FUN)
        Add: begin
            {Carry_Out_Comp, Arith_Comp} = A + B;
            Arith_Flag_Comp = 1'b1;
        end

        Subt: begin
            {Carry_Out_Comp, Arith_Comp} = A - B;
            Arith_Flag_Comp = 1'b1;
        end

        Mult: begin
            {Carry_Out_Comp, Arith_Comp} = A * B;
            Arith_Flag_Comp = 1'b1;
        end

        Div: begin
            {Carry_Out_Comp, Arith_Comp} = A / B;
            Arith_Flag_Comp = 1'b1;
        end

        default: begin
            {Carry_Out_Comp, Arith_Comp} = 'b0;
            Arith_Flag_Comp = 1'b0; 
        end
    endcase
end

endmodule