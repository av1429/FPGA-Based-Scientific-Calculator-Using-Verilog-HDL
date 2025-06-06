module math_unit (
    input logic [2:0] op_sel,        // 3-bit operation selector
    input logic signed [15:0] a,
    input logic signed [15:0] b,
    output logic signed [31:0] result,
    output logic valid
);
    // GCD/LCM functions (same as original)
    function automatic int gcd(input int x, input int y);
    int temp;
    for (int i = 0; i < 32; i++) begin
        if (y == 0) break;
        temp = y;
        y = x % y;
        x = temp;
    end
    return x;
endfunction


    function automatic int lcm(input int x, input int y);
        if (x == 0 || y == 0) return 0;
        return (x * y) / gcd(x, y);
    endfunction

   // Round: If LSB is 1, add 1 or -1 based on sign
    function automatic signed [15:0] round_func(input signed [15:0] a);
        round_func = (a[0]) ? a + ((a > 0) ? 1 : -1) : a;
    endfunction

    // Ceil: If any fractional bits are set and number is negative, add 1
    function automatic signed [15:0] ceil_func(input signed [15:0] a);
        // Here we treat a[14:0] as fractional bits
        // a[15] is sign bit
        ceil_func = (a[15] && |a[14:0]) ? a + 1 : a;
    endfunction

    // Floor: Just return the same number for integer values
    function automatic signed [15:0] floor_func(input signed [15:0] a);
        floor_func = a;
    endfunction

    always_comb begin
        valid = 1;
        case (op_sel)
            3'b000: result = a % b;                        // Modulo
            3'b001: result = a / b;                        // Floor Division
            3'b010: begin                                   // Power
                result = 1;
                for (int i = 0; i < 200; i++) result *= a;
            end
            3'b011: result = gcd(a, b);                    // GCD
            3'b100: result = lcm(a, b);                    // LCM
            3'b101: result = round_func(a);
	    3'b110: result = ceil_func(a);
	    3'b111: result = floor_func(a);
            default: begin
                result = 0;
                valid = 0;
            end
        endcase
    end

endmodule
