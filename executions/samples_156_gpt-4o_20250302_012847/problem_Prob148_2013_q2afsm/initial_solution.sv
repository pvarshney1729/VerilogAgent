module TopModule (
    input logic clk,
    input logic rst_n,  // Active-low reset
    input logic [1:0] device_request,  // Device request signals
    output logic [1:0] device_grant  // Device grant signals
);

    // State encoding
    typedef enum logic [1:0] {
        IDLE = 2'b00,
        DEVICE_0 = 2'b01,
        DEVICE_1 = 2'b10
    } state_t;

    state_t current_state, next_state;

    // State transition logic
    always_ff @(posedge clk) begin
        if (!rst_n) begin
            current_state <= IDLE;
        end else begin
            current_state <= next_state;
        end
    end

    // Next state logic and output logic
    always @(*) begin
        // Default assignments
        next_state = current_state;
        device_grant = 2'b00;

        case (current_state)
            IDLE: begin
                if (device_request[0]) begin
                    next_state = DEVICE_0;
                end else if (device_request[1]) begin
                    next_state = DEVICE_1;
                end
            end
            DEVICE_0: begin
                device_grant = 2'b01;
                if (!device_request[0]) begin
                    next_state = IDLE;
                end
            end
            DEVICE_1: begin
                device_grant = 2'b10;
                if (!device_request[1]) begin
                    next_state = IDLE;
                end
            end
            default: begin
                next_state = IDLE;
            end
        endcase
    end

endmodule