module boolean (
    input  logic [2:0] opcode,   // 3-bit selector for operation
    input  int         a, b,     // operands
    output logic       result    // result of the comparison
);

    always_comb begin
        case (opcode)
            3'd0: result = (a > b);          // Greater than
            3'd1: result = (a < b);          // Less than
            3'd2: result = (a == b);         // Equal
            3'd3: result = (a != b);         // Not equal
            3'd4: result = (a % 2 == 0);     // Is 'a' even
            3'd5: result = (b % 2 == 0);     // Is 'b' even
            default: result = 0;
        endcase
    end

endmodule
