`timescale 1ns/1ps

module ALU_TOP_TB #(parameter Op_Width = 16)();
reg [Op_Width - 1: 0] A_tb;
reg [Op_Width - 1: 0] B_tb;
reg [3 : 0] ALU_FUN_tb;
reg CLK_tb;
reg RST_tb;
wire Carry_OUT_tb;
wire [Op_Width - 1: 0] Arith_OUT_tb;
wire [Op_Width - 1: 0] Logic_OUT_tb;
wire [Op_Width - 1: 0] CMP_OUT_tb;
wire [Op_Width - 1: 0] Shift_OUT_tb;
wire Arith_FLAG_tb;
wire Logic_FLAG_tb;
wire CMP_FLAG_tb;
wire Shift_FLAG_tb;

// Connections
ALU_TOP M0(
    .A(A_tb),
    .B(B_tb),
    .ALU_FUN(ALU_FUN_tb),
    .CLK(CLK_tb),
    .RST(RST_tb),
    .Carry_OUT(Carry_OUT_tb),
    .Arith_OUT(Arith_OUT_tb),
    .Logic_OUT(Logic_OUT_tb),
    .CMP_OUT(CMP_OUT_tb),
    .Shift_OUT(Shift_OUT_tb),
    .Arith_FLAG(Arith_FLAG_tb),
    .Logic_FLAG(Logic_FLAG_tb),
    .CMP_FLAG(CMP_FLAG_tb),
    .Shift_FLAG(Shift_FLAG_tb)
);

//Clock Generation
parameter Clock_Perioed = 10;
always #(Clock_Perioed/2) CLK_tb = ~CLK_tb;

// Starting at time Zero
task initialize();
begin
    RST_tb = 1'b0;
    CLK_tb = 1'b0;
    A_tb = 'b0;
    B_tb = 'b0;
    ALU_FUN_tb = 4'b0;
end
endtask

// RESET
task RESET();
begin
    RST_tb = 1'b1;
    #(Clock_Perioed)
    RST_tb = 1'b0;
    #(Clock_Perioed)
    RST_tb = 1'b1;
end
endtask

//Test initiation 
initial begin
    $dumpfile("ALU_TOP.vcd");
    $dumpvars;

    /// initialize ///
    initialize();

    /// RST ////
    RESET();

/////////////////////////
///////Arithmatic///////
///////////////////////

//// Addition ////
    A_tb = 'd4;
    B_tb = 'd2;
    ALU_FUN_tb = 4'b0;
    #(Clock_Perioed)
    $display("The Results of Addition=%d", Arith_OUT_tb);

//// Subtraction ////
    ALU_FUN_tb = 4'b1;
    #(Clock_Perioed)
    $display("The Results of Subraction=%d", Arith_OUT_tb);

//// Multplication /////
    ALU_FUN_tb = 4'b10;
    #(Clock_Perioed)
    $display("The Results of Multplication=%d", Arith_OUT_tb);
    
//// Division ////
    ALU_FUN_tb = 4'b11;
    #(Clock_Perioed)
    $display("The Results of Division=%d", Arith_OUT_tb);

//// Reset After Each ALU Unit
    RESET();

    /// Logic Operations ///
    // New Values
    A_tb = 'b1010101010101010;
    B_tb = 'b1100110011001100;

    // AND Operation
    ALU_FUN_tb = 4'b0100;
    #(Clock_Perioed)
    if(Logic_OUT_tb == (A_tb & B_tb))
        $display("AND Operation Passed");
    else
        $display("AND Operation Failed");

    // OR Operation
    ALU_FUN_tb = 4'b0101;
    #(Clock_Perioed)
    if(Logic_OUT_tb == (A_tb | B_tb))
        $display("OR Operation Passed");
    else
        $display("OR Operation Failed");

    // NAND Operation
    ALU_FUN_tb = 4'b0110;
    #(Clock_Perioed)
    if(Logic_OUT_tb == ~(A_tb & B_tb))
        $display("NAND Operation Passed");
    else
        $display("NAND Operation Failed");

    // NOR Operation
    ALU_FUN_tb = 4'b0111;
    #(Clock_Perioed)
    if(Logic_OUT_tb == ~(A_tb | B_tb))
        $display("NOR Operation Passed");
    else
        $display("NOR Operation Failed");

    //// CMP Operations ////
    // New Values
    A_tb = 'b0111101011110011;
    B_tb = 'b1001011110000101;

    // NOP
    ALU_FUN_tb = 4'b1000;
    #(Clock_Perioed)
    if (CMP_OUT_tb == 0)
        $display("NOP Passed");
    else
        $display("NOP Failed");

    // Equality 
    ALU_FUN_tb = 4'b1001;
    #(Clock_Perioed)
    if (CMP_OUT_tb == 1)
        $display("A is Equal to B");
    else if (CMP_OUT_tb == 0)
        $display("A is not Equal to B");
    else
        $display("CMP Equality Failed");

    // Check if A is larger than B
    ALU_FUN_tb = 4'b1010;
    #(Clock_Perioed)
    if (CMP_OUT_tb == 2)
        $display("A is Larger than B");
    else if (CMP_OUT_tb == 0)
        $display("A is not larger than B");
    else
        $display("CMP checking A is Failed");

    // Check if B is larger than A
    ALU_FUN_tb = 4'b1011;
    #(Clock_Perioed)
    if(CMP_OUT_tb == 3)
        $display("B is Larger than A");
    else if(CMP_OUT_tb == 0)
        $display("B is not larger than A");
    else
        $display("CMP Checking B is failed");

    /// Shift Operations
    // Shift Right A
    ALU_FUN_tb = 4'b1100;
    #(Clock_Perioed)
    if (Shift_OUT_tb == (A_tb >> 1))
        $display("Shift A Right Passed");
    else
        $display("Shift A Right Failed");

    // Shift Left A
    ALU_FUN_tb = 4'b1101;
    #(Clock_Perioed)
    if(Shift_OUT_tb == (A_tb << 1))
        $display("Shift A Left Passed");
    else
        $display("Shift A Left Failed");

    // Shift Right B
    ALU_FUN_tb = 4'b1110;
    #(Clock_Perioed)
    if (Shift_OUT_tb == (B_tb >> 1))
        $display("Shift Right B Passed");
    else
        $display("Shift Right B Failed");

    // Shift Left B
    ALU_FUN_tb = 4'b1111;
    #(Clock_Perioed);
    if (Shift_OUT_tb == (B_tb << 1))
        $display("Shift B Left passed");
    else
        $display("Shift B Left Failed");

    $display("Congratulations You have Finished all the Test Cases :)");

            

    #50
    $stop;
end
endmodule