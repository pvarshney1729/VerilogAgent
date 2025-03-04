module TopModule(
    input logic clk,         // Clock input
    input logic reset,       // Synchronous active-high reset
    input logic in,          // Data stream input
    output logic disc,       // Signal for discarding a bit
    output logic flag,       // Signal for frame boundary
    output logic err         // Signal for error condition
);

    typedef enum logic [3:0] {
        IDLE = 4'b0000,
        S1   = 4'b0001,
        S2   = 4'b0010,
        S3   = 4'b0011,
        S4   = 4'b0100,
        S5   = 4'b0101,
        S6   = 4'b0110,
        DISC = 4'b0111,
        FLAG = 4'b1000,
        ERR  = 4'b1001
    } state_t;

    state_t current_state, next_state;
    logic [2:0] one_count;

    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
            one_count <= 3'b000;
        end else begin
            current_state <= next_state;
            if (current_state == S5 && in == 1'b1) begin
                one_count <= one_count + 1;
            end else if (in == 1'b0) begin
                one_count <= 3'b000;
            end
        end
    end

    always_comb begin
        next_state = current_state;
        disc = 1'b0;
        flag = 1'b0;
        err = 1'b0;

        case (current_state)
            IDLE: begin
                if (in == 1'b0) next_state = S1;
            end
            S1: begin
                if (in == 1'b1) next_state = S2;
                else next_state = S1;
            end
            S2: begin
                if (in == 1'b1) next_state = S3;
                else next_state = S1;
            end
            S3: begin
                if (in == 1'b1) next_state = S4;
                else next_state = S1;
            end
            S4: begin
                if (in == 1'b1) next_state = S5;
                else next_state = S1;
            end
            S5: begin
                if (in == 1'b1) begin
                    if (one_count == 3'b110) next_state = ERR;
                    else next_state = S6;
                end else next_state = DISC;
            end
            S6: begin
                if (in == 1'b0) next_state = FLAG;
                else next_state = ERR;
            end
            DISC: begin
                disc = 1'b1;
                next_state = IDLE;
            end
            FLAG: begin
                flag = 1'b1;
                next_state = IDLE;
            end
            ERR: begin
                err = 1'b1;
                if (in == 1'b0) next_state = IDLE;
            end
            default: next_state = IDLE;
        endcase
    end

endmodule