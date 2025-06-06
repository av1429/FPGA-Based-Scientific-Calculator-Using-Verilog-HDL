module arithmetic_unit (
    input logic [2:0] op_sel,        // 000-add, 001-sub, 010-mul, 011-div
    input logic signed [15:0] a,     // First operand
    input logic signed [15:0] b,     // Second operand
    output logic signed [31:0] result, // Output result
    output logic valid               // Validity flag (for division by 0)
);

    always_comb begin
        // Default values
        result = 0;
        valid = 1;
        
        case (op_sel)
            3'b000: result = a + b;    // Addition
            3'b001: result = a - b;    // Subtraction
            3'b010: result = a * b;    // Multiplication
            3'b011: begin             // Division
                if (b != 0) begin
                    result = a / b;
                end else begin
                    result = 0;
                    valid = 0;       // Invalid flag for division by zero
                end
            end
            default: valid = 0;       // Invalid operation
        endcase
    end

endmodule

