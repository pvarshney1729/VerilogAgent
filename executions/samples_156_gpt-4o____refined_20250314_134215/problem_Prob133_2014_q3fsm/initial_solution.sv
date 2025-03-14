[BEGIN]
module TopModule (
    input  logic clk,
    input  logic reset,
    input  logic s,
    input  logic w,
    output logic z
);

    typedef enum logic [1:0] {
        A = 2'b00,
        B = 2'b01,
        C = 2'b10,
        D = 2'b11
    } state_t;

    state_t current_state, next_state;
    logic [1:0] w_count;

    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= A;
            w_count <= 2'b00;
            z <= 1'b0;
        end else begin
            current_state <= next_state;
            if (current_state == B || current_state == C || current_state == D) begin
                if (w) w_count <= w_count + 1;
            end else begin
                w_count <= 2'b00;
            end
            if (current_state == D && w_count == 2'b10) begin
                z <= 1'b1;
            end else begin
                z <= 1'b0;
            end
        end
    end

    always @(*) begin
        next_state = current_state;
        case (current_state)
            A: begin
                if (s) next_state = B;
            end
            B: begin
                if (w_count == 2'b10) begin
                    next_state = B;
                end else begin
                    next_state = C;
                end
            end
            C: begin
                if (w_count == 2'b10) begin
                    next_state = B;
                end else begin
                    next_state = D;
                end
            end
            D: begin
                next_state = B;
            end
        endcase
    end

endmodule
[DONE]