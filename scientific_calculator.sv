module scientific_calculator (
    input logic clk,
    input logic rst,
    input logic [5:0] SW,         // SW[5:3] = category, SW[2:0] = sub-op
    output logic signed [31:0] result,
    output logic bool_result,
    output [7:0] lcd_data,
    output lcd_rs,
    output lcd_rw,
    output lcd_e
);

    // Fixed operands 
    logic signed [15:0] a = 15;
    logic signed [15:0] b = 4;

    // Internal signals
    logic signed [31:0] arith_result, bitwise_result, math_result, stat_result;
    logic arith_valid, math_valid;

    // Instantiate all functional units
    arithmetic_unit arith (
        .op_sel(SW[2:0]),
        .a(a),
        .b(b),
        .result(arith_result),
        .valid(arith_valid)
    );

    bitwise_unit bitwise (
        .op_sel(SW[2:0]),
        .a(a),
        .b(b),
        .result(bitwise_result)
    );

    math_unit math (
        .op_sel(SW[2:0]),
        .a(a),
        .b(b),
        .result(math_result),
        .valid(math_valid)
    );

    statistical_unit stats (
        .a(a),
        .b(b),
        .op_sel(SW[2:0]),
        .result(stat_result)
    );

    boolean bool (
        .opcode(SW[2:0]),
        .a(a),
        .b(b),
        .result(bool_result)
    );

    // Import packages
    import conversion::*;
    import misc_ops::*;

    // Output selection
    always_comb begin
        case (SW[5:3])
            3'b001: result = arith_valid ? arith_result : 0;
            3'b010: result = bitwise_result;
            3'b011: result = math_valid ? math_result : 0;
            3'b100: begin
                case (SW[2:0])
                    3'b000: result = dec_to_bin(a);
                    3'b001: result = dec_to_oct(a);
                    3'b010: result = dec_to_hex(a);
                    3'b011: result = dec_to_bcd(a);
                    default: result = 0;
                endcase
            end
            3'b101: result = stat_result;
            3'b110: result = 0;
            3'b111: begin
                case (SW[2:0])
                    3'b000: result = factorial(a);
                    3'b001: result = permutation(a, b);
                    3'b010: result = combination(a, b);
                    default: result = 0;
                endcase
            end
            default: result = 0;
        endcase
    end

    // LCD display instance
    lcd_display lcd_inst (
        .clk(clk),
        .rst(rst),
        .data_in(result),
        .lcd_data(lcd_data),
        .lcd_rs(lcd_rs),
        .lcd_rw(lcd_rw),
        .lcd_e(lcd_e)
    );

endmodule
