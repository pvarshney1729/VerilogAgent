module TopModule (
    input logic clk,
    input logic reset,
    input logic train_valid,
    input logic train_taken,
    output logic [3:0] state
);

    logic [3:0] current_state;
    logic [3:0] next_state;

    // Synchronous reset and state update
    always @(posedge clk) begin
        if (reset) begin
            current_state <= 4'b0000; // Initialize state to zero
        end else begin
            current_state <= next_state;
        end
    end

    // Next state logic
    always @(*) begin
        case (current_state)
            4'b0000: next_state = train_valid ? (train_taken ? 4'b0001 : 4'b0010) : 4'b0000;
            4'b0001: next_state = train_valid ? (train_taken ? 4'b0011 : 4'b0000) : 4'b0001;
            4'b0010: next_state = train_valid ? (train_taken ? 4'b0000 : 4'b0011) : 4'b0010;
            4'b0011: next_state = train_valid ? (train_taken ? 4'b0010 : 4'b0000) : 4'b0011;
            default: next_state = 4'b0000; // Default case
        endcase
    end

    // Output the current state
    assign state = current_state;

endmodule