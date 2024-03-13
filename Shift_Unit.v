module ALU_Shift_Unit #(parameter Op_Width = 16)(
    input [Op_Width - 1: 0] A, B,
    input [1 : 0] ALU_FUN,
    input CLK, RST, Shift_En,
    output reg [Op_Width - 1: 0] Shift_Out,
    output reg Shift_Flag
);

//Internal Signals
reg [Op_Width - 1: 0] Shift_Comp;
reg Shift_Flag_Comp;

//Local Parameters
localparam  A_Shift_Right  =  2'b00,
            A_Shift_Left   = 2'b01,
            B_Shift_Right = 2'b10,
            B_Shift_Left  = 2'b11;

// All O/P are Regstered 
always@(posedge CLK or negedge RST)
begin
    if(!RST || !Shift_En)
        begin
            Shift_Out <= 'b0;
            Shift_Flag <= 1'b0;
        end

    else
        begin
            Shift_Out <= Shift_Comp;
            Shift_Flag <= Shift_Flag_Comp;
        end
end

always@(*)
begin
    Shift_Comp = 'b0;
    Shift_Flag_Comp = 1'b0;
    case(ALU_FUN)
        A_Shift_Right: begin
            Shift_Comp = A >> 1;
            Shift_Flag_Comp = 1'b1;
        end

        A_Shift_Left: begin
            Shift_Comp = A << 1;
            Shift_Flag_Comp = 1'b1;
        end

        B_Shift_Right: begin
            Shift_Comp = B >> 1;
            Shift_Flag_Comp = 1'b1;
        end

        B_Shift_Left: begin
            Shift_Comp = B << 1;
            Shift_Flag_Comp = 1'b1;
        end

        default: begin
            Shift_Comp = 'b0;
            Shift_Flag_Comp = 1'b0; 
        end
    endcase
end
endmodule