module TopModule (
    input logic clk,
    input logic reset,
    input logic w,
    output logic z
);

    typedef enum logic [2:0] {
        A = 3'b000,
        B = 3'b001,
        C = 3'b010,
        D = 3'b011,
        E = 3'b100,
        F = 3'b101
    } state_t;

    state_t current_state, next_state;

    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= A;
            z <= 0;
        end else begin
            current_state <= next_state;
        end
    end

    always_comb begin
        case (current_state)
            A: begin
                if (w == 0) begin
                    next_state = B;
                    z = 0;
                end else begin
                    next_state = A;
                    z = 0;
                end
            end
            B: begin
                if (w == 0) begin
                    next_state = C;
                    z = 0;
                end else begin
                    next_state = D;
                    z = 0;
                end
            end
            C: begin
                if (w == 0) begin
                    next_state = E;
                    z = 0;
                end else begin
                    next_state = D;
                    z = 0;
                end
            end
            D: begin
                if (w == 0) begin
                    next_state = F;
                    z = 0;
                end else begin
                    next_state = A;
                    z = 0;
                end
            end
            E: begin
                if (w == 0) begin
                    next_state = E;
                    z = 1;
                end else begin
                    next_state = D;
                    z = 1;
                end
            end
            F: begin
                if (w == 0) begin
                    next_state = C;
                    z = 1;
                end else begin
                    next_state = D;
                    z = 1;
                end
            end
            default: begin
                next_state = A;
                z = 0;
            end
        endcase
    end

endmodule