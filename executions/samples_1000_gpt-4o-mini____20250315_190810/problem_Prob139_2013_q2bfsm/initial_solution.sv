module TopModule (
    input logic clk,
    input logic resetn,
    input logic x,
    input logic y,
    output logic f,
    output logic g
);

    typedef enum logic [2:0] {
        STATE_A,
        STATE_B,
        STATE_C,
        STATE_D
    } state_t;

    state_t current_state, next_state;
    logic [2:0] x_sequence;
    logic y_detected;

    always_ff @(posedge clk) begin
        if (!resetn) begin
            current_state <= STATE_A;
            f <= 1'b0;
            g <= 1'b0;
            x_sequence <= 3'b000;
        end else begin
            current_state <= next_state;
            if (current_state == STATE_B) begin
                f <= 1'b1;
            end else begin
                f <= 1'b0;
            end
        end
    end

    always_ff @(posedge clk) begin
        if (current_state == STATE_A) begin
            if (!resetn) begin
                next_state <= STATE_A;
            end else begin
                next_state <= STATE_B;
            end
        end else if (current_state == STATE_B) begin
            x_sequence <= {x_sequence[1:0], x};
            if (x_sequence == 3'b101) begin
                next_state <= STATE_C;
            end else begin
                next_state <= STATE_B;
            end
        end else if (current_state == STATE_C) begin
            g <= 1'b1;
            if (y) begin
                next_state <= STATE_C;
            end else begin
                next_state <= STATE_D;
            end
        end else if (current_state == STATE_D) begin
            g <= 1'b0;
            if (y) begin
                next_state <= STATE_C;
            end else begin
                next_state <= STATE_D;
            end
        end
    end

    always_ff @(posedge clk) begin
        if (current_state == STATE_C) begin
            y_detected <= y_detected || y;
        end
    end

endmodule