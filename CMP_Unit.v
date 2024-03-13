module ALU_CMP_Unit #(parameter Op_Width = 16)(
    input [Op_Width - 1: 0] A, B,
    input [1 : 0] ALU_FUN,
    input CLK, RST, CMP_En,
    output reg [Op_Width - 1: 0] CMP_Out,
    output reg CMP_Flag
);

//Internal Signals
reg [Op_Width - 1: 0] CMP_Comp;
reg CMP_Flag_Comp;

//Local Parameters
localparam  NOP  =  2'b00,
            Equal   = 2'b01,
            Larger = 2'b10,
            Smaller  = 2'b11;

// All O/P are Regstered 
always@(posedge CLK or negedge RST)
begin
    if(!RST || !CMP_En)
        begin
            CMP_Out <= 'b0;
            CMP_Flag <= 1'b0;
        end

    else
        begin
            CMP_Out <= CMP_Comp;
            CMP_Flag <= CMP_Flag_Comp;
        end
end

always@(*)
begin
    CMP_Comp = 'b0;
    CMP_Flag_Comp = 1'b0;
    case(ALU_FUN)
        NOP: begin
            CMP_Comp = 'b0;
            CMP_Flag_Comp = 1'b1;
        end

        Equal: begin
                    if(A == B)
                        CMP_Comp = 'b1;
                    else
                        CMP_Comp = 'b0;
            CMP_Flag_Comp = 1'b1;
        end

        Larger: begin
                    if(A > B)
                        CMP_Comp = 'd2;
                    else
                        CMP_Comp = 'b0;
            CMP_Flag_Comp = 1'b1;
        end

        Smaller: begin
                    if(A < B)
                        CMP_Comp = 'd3;
                    else
                        CMP_Comp = 'b0;
            CMP_Flag_Comp = 1'b1;
        end

        default: begin
            CMP_Comp = 'b0;
            CMP_Flag_Comp = 1'b0; 
        end
    endcase
end
endmodule