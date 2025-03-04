module TopModule (
    input logic clk,
    input logic resetn,
    input logic [2:0] r,
    output logic [2:0] g
);

    typedef enum logic [1:0] {
        A = 2'b00,
        B = 2'b01,
        C = 2'b10,
        D = 2'b11
    } state_t;

    state_t current_state, next_state;

    always_ff @(posedge clk) begin
        if (!resetn) begin
            current_state <= A;
        end else begin
            current_state <= next_state;
        end
    end

    always_comb begin
        case (current_state)
            A: begin
                if (r[0]) begin
                    next_state = B;
                end else if (r[1]) begin
                    next_state = C;
                end else if (r[2]) begin
                    next_state = D;
                end else begin
                    next_state = A;
                end
            end
            B: begin
                if (r[0]) begin
                    next_state = B;
                end else begin
                    next_state = A;
                end
            end
            C: begin
                if (r[1]) begin
                    next_state = C;
                end else begin
                    next_state = A;
                end
            end
            D: begin
                if (r[2]) begin
                    next_state = D;
                end else begin
                    next_state = A;
                end
            end
            default: next_state = A;
        endcase
    end

    always_ff @(posedge clk) begin
        case (current_state)
            A: g <= 3'b000;
            B: g <= 3'b001;
            C: g <= 3'b010;
            D: g <= 3'b100;
            default: g <= 3'b000;
        endcase
    end

endmodule

// VERILOG-EVAL: response did not use [BEGIN]/[DONE] correctly