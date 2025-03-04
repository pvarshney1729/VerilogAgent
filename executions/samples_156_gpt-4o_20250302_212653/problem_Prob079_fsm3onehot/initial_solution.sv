module TopModule (
    input logic clk,
    input logic rst_n,
    input logic in,
    output logic [3:0] next_state,
    output logic out
);

    logic [3:0] current_state;

    // State Transition and Output Logic
    always @(*) begin
        case (current_state)
            4'b0001: begin // State A
                next_state = in ? 4'b0010 : 4'b0001;
                out = 0;
            end
            4'b0010: begin // State B
                next_state = in ? 4'b0010 : 4'b0100;
                out = 0;
            end
            4'b0100: begin // State C
                next_state = in ? 4'b1000 : 4'b0001;
                out = 0;
            end
            4'b1000: begin // State D
                next_state = in ? 4'b0010 : 4'b0100;
                out = 1;
            end
            default: begin // Undefined states
                next_state = 4'b0001; // Reset to A
                out = 0;
            end
        endcase
    end

    // Sequential Logic for State Register
    always @(posedge clk) begin
        if (!rst_n)
            current_state <= 4'b0001; // Reset state to A
        else
            current_state <= next_state;
    end

endmodule