module statistical_unit (
    input  wire signed [15:0] a,
    input  wire signed [15:0] b,
    input  wire [2:0] op_sel,
    output logic signed [31:0] result
);

    // Function to compute MEAN
    function automatic signed [31:0] mean(input signed [15:0] x, y);
        mean = (x + y) >>> 1;
    endfunction

    // Function to compute MAX
    function automatic signed [31:0] max(input signed [15:0] x, y);
        max = (x > y) ? x : y;
    endfunction

    // Function to compute MIN
    function automatic signed [31:0] min(input signed [15:0] x, y);
        min = (x < y) ? x : y;
    endfunction

    always_comb begin
        case (op_sel)
            3'b000: result = mean(a, b);
            3'b001: result = max(a, b);
            3'b010: result = min(a, b);
            default: result = 0;
        endcase
    end

endmodule
