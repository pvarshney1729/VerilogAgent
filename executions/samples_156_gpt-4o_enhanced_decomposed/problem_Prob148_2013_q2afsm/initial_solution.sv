module TopModule(
    input logic clk,
    input logic resetn,
    input logic [2:0] r,
    output logic [2:0] g
);

    // State encoding
    typedef enum logic [1:0] {
        A = 2'b00,
        B = 2'b01,
        C = 2'b10,
        D = 2'b11
    } state_t;

    state_t current_state, next_state;

    // State transition logic
    always @(*) begin
        case (current_state)
            A: begin
                if (r[0]) next_state = B;
                else if (r[1]) next_state = C;
                else if (r[2]) next_state = D;
                else next_state = A;
            end
            B: begin
                if (r[0]) next_state = B;
                else next_state = A;
            end
            C: begin
                if (r[1]) next_state = C;
                else next_state = A;
            end
            D: begin
                next_state = A;
            end
            default: next_state = A;
        endcase
    end

    // State update logic
    always @(posedge clk) begin
        if (!resetn)
            current_state <= A;
        else
            current_state <= next_state;
    end

    // Output logic
    always @(*) begin
        case (current_state)
            B: g = 3'b001;
            C: g = 3'b010;
            default: g = 3'b000;
        endcase
    end

endmodule