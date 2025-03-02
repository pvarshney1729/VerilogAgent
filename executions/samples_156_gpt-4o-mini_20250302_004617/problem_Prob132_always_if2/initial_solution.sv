module TopModule (
    input logic clk,
    input logic reset,
    input logic shutdown_request,
    output logic shutdown_signal,
    output logic drive_signal
);

    logic state;
    logic next_state;

    // State encoding
    localparam IDLE = 1'b0;
    localparam SHUTDOWN = 1'b1;

    // Synchronous reset and state transition
    always @(posedge clk) begin
        if (reset) begin
            state <= 1'b0; // Initialize to IDLE state
        end else begin
            state <= next_state;
        end
    end

    // Next state logic
    always @(*) begin
        case (state)
            IDLE: begin
                if (shutdown_request) begin
                    next_state = SHUTDOWN;
                end else begin
                    next_state = IDLE;
                end
            end
            SHUTDOWN: begin
                next_state = SHUTDOWN; // Remain in SHUTDOWN state
            end
            default: begin
                next_state = IDLE; // Default to IDLE
            end
        endcase
    end

    // Output logic
    assign shutdown_signal = (state == SHUTDOWN);
    assign drive_signal = (state == IDLE);

endmodule