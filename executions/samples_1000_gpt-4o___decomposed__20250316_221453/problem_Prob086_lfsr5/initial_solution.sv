module TopModule(
    input logic clk,
    input logic reset,
    output logic [4:0] q
);

    logic [4:0] current_state, next_state;

    // Combinational logic to determine the next state
    always @(*) begin
        case (current_state)
            5'b00001: next_state = 5'b00010;
            5'b00010: next_state = 5'b00100;
            5'b00100: next_state = 5'b01000;
            5'b01000: next_state = 5'b10000;
            5'b10000: next_state = 5'b10011;
            5'b10011: next_state = 5'b11001;
            5'b11001: next_state = 5'b11111;
            5'b11111: next_state = 5'b01110;
            5'b01110: next_state = 5'b00111;
            5'b00111: next_state = 5'b01101;
            5'b01101: next_state = 5'b00011;
            5'b00011: next_state = 5'b11110;
            5'b11110: next_state = 5'b01111;
            5'b01111: next_state = 5'b11010;
            5'b11010: next_state = 5'b10110;
            5'b10110: next_state = 5'b01011;
            5'b01011: next_state = 5'b01001;
            5'b01001: next_state = 5'b10111;
            5'b10111: next_state = 5'b11011;
            5'b11011: next_state = 5'b11101;
            5'b11101: next_state = 5'b00110;
            5'b00110: next_state = 5'b10001;
            5'b10001: next_state = 5'b11100;
            5'b11100: next_state = 5'b10101;
            5'b10101: next_state = 5'b10010;
            5'b10010: next_state = 5'b00001;
            default: next_state = 5'b00000;
        endcase
    end

    // Sequential logic for state update
    always @(posedge clk) begin
        if (reset) begin
            current_state <= 5'b00001;
        end else begin
            current_state <= next_state;
        end
    end

    // Output assignment
    assign q = current_state;

endmodule