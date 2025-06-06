module bitwise_unit (
    input logic [2:0] op_sel,        // 3-bit operation selector
    input logic signed [15:0] a,
    input logic signed [15:0] b,
    output logic signed [31:0] result
);

    always_comb begin
        case (op_sel)
            3'b000: result = a & b;       // AND
            3'b001: result = a | b;       // OR
            3'b010: result = a ^ b;       // XOR
            3'b011: result = ~a;          // NOT
            3'b100: result = a <<< b;     // Left Shift
            3'b101: result = a >>> b;     // Right Shift
            3'b110: result = (a < 0) ? -a : a; // Absolute Value
            default: result = 0;
        endcase
    end

endmodule

