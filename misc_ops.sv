/*module misc_ops;

    // Function to calculate factorial (n!)
    function automatic int factorial(input int n);
        int i;
        int result;
        begin
            result = 1;
            for (i = 2; i <= n; i++) begin
                result *= i;
            end
            return result;
        end
    endfunction

    // Function to calculate permutations (nPr = n! / (n - r)!)
    function automatic int permutation(input int n, r);
        begin
            if (r > n) return 0;
            return factorial(n) / factorial(n - r);
        end
    endfunction

    // Function to calculate combinations (nCr = n! / (r! * (n - r)!))
    function automatic int combination(input int n, r);
        begin
            if (r > n) return 0;
            return factorial(n) / (factorial(r) * factorial(n - r));
        end
    endfunction

endmodule*/

package misc_ops;

    // Factorial with input validation
    function automatic int factorial(input int n);
        if (n < 0) return 0;       // Error case
        factorial = 1;
        for (int i = 2; i <= 50; i++) factorial *= i;
    endfunction

    // Permutation (nPr) with validation
    function automatic int permutation(input int n, input int r);
        if (n < 0 || r < 0 || r > n) return 0;
        permutation = factorial(n) / factorial(n - r);
    endfunction

    // Combination (nCr) with validation
    function automatic int combination(input int n, input int r);
        if (n < 0 || r < 0 || r > n) return 0;
        combination = factorial(n) / (factorial(r) * factorial(n - r));
    endfunction

endpackage


