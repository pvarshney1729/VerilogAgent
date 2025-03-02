module pattern_timer (
    input logic clk,
    input logic reset,
    input logic data,
    input logic ack,
    output logic [3:0] count,
    output logic counting,
    output logic done
);

    logic [3:0] delay;
    logic [3:0] next_count;
    logic [3:0] bit_counter;
    logic [3:0] shift_reg;
    logic detecting_pattern;
    
    // State machine for pattern detection and counting
    always @(posedge clk) begin
        if (reset) begin
            count <= 4'b0000;
            counting <= 1'b0;
            done <= 1'b0;
            detecting_pattern <= 1'b1;
            bit_counter <= 4'b0000;
            shift_reg <= 4'b0000;
        end else begin
            if (detecting_pattern) begin
                // Shift in data to detect pattern 1101
                shift_reg <= {shift_reg[2:0], data};
                if (shift_reg == 4'b1101) begin
                    detecting_pattern <= 1'b0;
                    bit_counter <= 4'b0000;
                end
            end else if (bit_counter < 4'b0100) begin
                // Shift in delay bits
                delay[3 - bit_counter] <= data;
                bit_counter <= bit_counter + 1;
                if (bit_counter == 4'b0011) begin
                    count <= delay; // Initialize count with delay value
                    counting <= 1'b1;
                end
            end else if (counting) begin
                if (count == 4'b0000) begin
                    done <= 1'b1;
                    counting <= 1'b0;
                end else if (clk % 1000 == 0) begin
                    count <= count - 1;
                end
            end
        end
    end

    // Acknowledge handling
    always @(posedge clk) begin
        if (done && ack) begin
            done <= 1'b0;
            detecting_pattern <= 1'b1;
        end
    end

endmodule