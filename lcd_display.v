module lcd_display(
    input clk,
    input rst,
    input signed [31:0] data_in,
    output reg [7:0] lcd_data,
    output reg lcd_rs,
    output reg lcd_rw,
    output reg lcd_e
);

    reg [3:0] state = 0;
    reg [25:0] delay_counter = 0;
    parameter DELAY = 500000; // Adjust as needed

    reg [3:0] char_index = 0;
    reg [7:0] char_array [9:0];  // Max 10 characters including sign
    reg signed [31:0] num;
    reg is_negative;

    task int_to_ascii;
        integer i;
        reg [31:0] temp;
        begin
            temp = (data_in < 0) ? -data_in : data_in;
            is_negative = (data_in < 0);
            for (i = 0; i < 10; i = i + 1) char_array[i] = 8'd32;  // Clear with space

            i = 9;
            if (temp == 0) begin
                char_array[i] = "0";
                i = i - 1;
            end else begin
                while (temp != 0 && i >= 0) begin
                    char_array[i] = (temp % 10) + 8'd48;
                    temp = temp / 10;
                    i = i - 1;
                end
            end
            if (is_negative && i >= 0)
                char_array[i] = "-";
            else
                i = i + 1;

            // Shift characters to beginning
            for (char_index = 0; char_index < 10; char_index = char_index + 1)
                char_array[char_index] = char_array[i + char_index];
        end
    endtask

    initial begin
        lcd_data = 0;
        lcd_rs = 0;
        lcd_rw = 0;
        lcd_e = 0;
        char_index = 0;
        int_to_ascii();
    end

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            lcd_data <= 0;
            lcd_rs <= 0;
            lcd_rw <= 0;
            lcd_e <= 0;
            delay_counter <= 0;
            state <= 0;
            char_index <= 0;
        end else begin
            if (delay_counter < DELAY) begin
                delay_counter <= delay_counter + 1;
                lcd_e <= 0;
            end else begin
                delay_counter <= 0;
                lcd_e <= 1;

                case (state)
                    0: begin // Function Set
                        lcd_data <= 8'b00111000;
                        lcd_rs <= 0;
                        lcd_rw <= 0;
                        state <= 1;
                    end
                    1: begin // Display On
                        lcd_data <= 8'b00001100;
                        lcd_rs <= 0;
                        lcd_rw <= 0;
                        state <= 2;
                    end
                    2: begin // Clear Display
                        lcd_data <= 8'b00000001;
                        lcd_rs <= 0;
                        lcd_rw <= 0;
                        state <= 3;
                    end
                    3: begin // Set Cursor to Line 1
                        lcd_data <= 8'b10000000;
                        lcd_rs <= 0;
                        lcd_rw <= 0;
                        int_to_ascii();
                        char_index <= 0;
                        state <= 4;
                    end
                    4: begin // Print characters
                        if (char_index < 10 && char_array[char_index] != 8'd32) begin
                            lcd_data <= char_array[char_index];
                            lcd_rs <= 1;
                            lcd_rw <= 0;
                            char_index <= char_index + 1;
                        end else begin
                            state <= 5;
                        end
                    end
                    default: state <= 5;
                endcase
            end
        end
    end
endmodule
