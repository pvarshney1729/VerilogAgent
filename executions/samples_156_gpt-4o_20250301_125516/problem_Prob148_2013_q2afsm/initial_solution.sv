module TopModule (
    input logic clk,            // Clock signal
    input logic resetn,         // Active-low synchronous reset
    input logic [2:0] r,        // 3-bit request signal from devices
    output logic [2:0] g        // 3-bit grant signal to devices
);

    typedef enum logic [1:0] {
        A = 2'b00,
        B = 2'b01,
        C = 2'b10,
        D = 2'b11
    } state_t;

    state_t current_state, next_state;

    // State transition logic
    always_ff @(posedge clk) begin
        if (!resetn) begin
            current_state <= A;
        end else begin
            current_state <= next_state;
        end
    end

    // Next state logic and output logic
    always_comb begin
        // Default assignments
        next_state = current_state;
        g = 3'b000;

        case (current_state)
            A: begin
                if (r[0]) begin
                    next_state = B;
                    g = 3'b001;
                end else if (r[1]) begin
                    next_state = C;
                    g = 3'b010;
                end else if (r[2]) begin
                    next_state = D;
                    g = 3'b100;
                end
            end
            B: begin
                if (!r[0]) begin
                    next_state = A;
                end else begin
                    g = 3'b001;
                end
            end
            C: begin
                if (!r[1]) begin
                    next_state = A;
                end else begin
                    g = 3'b010;
                end
            end
            D: begin
                if (!r[2]) begin
                    next_state = A;
                end else begin
                    g = 3'b100;
                end
            end
        endcase
    end

endmodule