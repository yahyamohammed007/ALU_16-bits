module ALU_Logic_Unit #(parameter Op_Width = 16)(
    input [Op_Width - 1: 0] A, B,
    input [1 : 0] ALU_FUN,
    input CLK, RST, Logic_En,
    output reg [Op_Width - 1: 0] Logic_Out,
    output reg Logic_Flag
);

//Internal Signals
reg [Op_Width - 1: 0] Logic_Comp;
reg Logic_Flag_Comp;

//Local Parameters
localparam  AND  =  2'b00,
            OR   = 2'b01,
            NAND = 2'b10,
            NOR  = 2'b11;

// All O/P are Regstered 
always@(posedge CLK or negedge RST)
begin
    if(!RST || !Logic_En)
        begin
            Logic_Out <= 'b0;
            Logic_Flag <= 1'b0;
        end

    else
        begin
            Logic_Out <= Logic_Comp;
            Logic_Flag <= Logic_Flag_Comp;
        end
end

always@(*)
begin
    Logic_Comp = 'b0;
    Logic_Flag_Comp = 1'b0;
    case(ALU_FUN)
        AND: begin
            Logic_Comp = A & B;
            Logic_Flag_Comp = 1'b1;
        end

        OR: begin
            Logic_Comp = A | B;
            Logic_Flag_Comp = 1'b1;
        end

        NAND: begin
            Logic_Comp = ~(A & B);
            Logic_Flag_Comp = 1'b1;
        end

        NOR: begin
            Logic_Comp = ~(A | B);
            Logic_Flag_Comp = 1'b1;
        end

        default: begin
            Logic_Comp = 'b0;
            Logic_Flag_Comp = 1'b0; 
        end
    endcase
end


endmodule