module ALU_Decoder(
    input [1 : 0] ALU_FUN,
    output reg Arith_En, Logic_En, CMP_En, Shift_En
);

localparam  Arith_Case = 2'b00,
            Logic_Case = 2'b01,
            CMP_Case = 2'b10,
            Shift_Case = 2'b11;

always @(*)
begin
    Arith_En = 1'b0;
    Logic_En = 1'b0;
    CMP_En = 1'b0;
    Shift_En = 1'b0;
     case(ALU_FUN)
     //Arith Enable
        Arith_Case: Arith_En = 1'b1;
     //Logic Enable
        Logic_Case: Logic_En = 1'b1;
     //CMP Enable
        CMP_Case:   CMP_En = 1'b1;
     //Shift Enable
        Shift_Case: Shift_En = 1'b1;
     //Default Case
        default: begin
         Arith_En = 1'b0;
         Logic_En = 1'b0;
         CMP_En = 1'b0;
         Shift_En = 1'b0;
        end
     endcase
end

endmodule