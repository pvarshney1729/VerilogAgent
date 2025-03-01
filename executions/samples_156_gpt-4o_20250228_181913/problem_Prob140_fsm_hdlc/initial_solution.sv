module TopModule(
    input logic clk,
    input logic reset,
    input logic in,
    output logic disc,
    output logic flag,
    output logic err
);

    typedef enum logic [2:0] {
        Idle    = 3'b000,
        Count1  = 3'b001,
        Count2  = 3'b010,
        Count3  = 3'b011,
        Count4  = 3'b100,
        Count5  = 3'b101,
        Count6  = 3'b110,
        Error   = 3'b111
    } state_t;

    state_t current_state, next_state;

    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= Idle;
        end else begin
            current_state <= next_state;
        end
    end

    always_comb begin
        // Default output values
        disc = 1'b0;
        flag = 1'b0;
        err = 1'b0;
        next_state = current_state;

        case (current_state)
            Idle: begin
                if (in) next_state = Count1;
            end
            Count1: begin
                if (in) next_state = Count2;
                else next_state = Idle;
            end
            Count2: begin
                if (in) next_state = Count3;
                else next_state = Idle;
            end
            Count3: begin
                if (in) next_state = Count4;
                else next_state = Idle;
            end
            Count4: begin
                if (in) next_state = Count5;
                else next_state = Idle;
            end
            Count5: begin
                if (in) next_state = Count6;
                else begin
                    next_state = Idle;
                    disc = 1'b1;
                end
            end
            Count6: begin
                if (in) next_state = Error;
                else begin
                    next_state = Idle;
                    flag = 1'b1;
                end
            end
            Error: begin
                err = 1'b1;
                if (!in) next_state = Idle;
            end
            default: next_state = Idle;
        endcase
    end

endmodule