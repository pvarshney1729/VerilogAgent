module TopModule (
    input logic clk,
    input logic reset,
    input logic [2:0] s,
    output logic fr2,
    output logic fr1,
    output logic fr0,
    output logic dfr
);

    typedef enum logic [1:0] {
        LOW = 2'b00,
        MID = 2'b01,
        HIGH = 2'b10,
        ABOVE = 2'b11
    } state_t;

    state_t current_state, next_state;

    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= LOW;
        end else begin
            current_state <= next_state;
        end
    end

    always_comb begin
        // Default outputs
        fr2 = 1'b0;
        fr1 = 1'b0;
        fr0 = 1'b0;
        dfr = 1'b0;

        case (current_state)
            ABOVE: begin
                if (s == 3'b110) begin
                    next_state = MID;
                end else begin
                    next_state = ABOVE;
                end
            end
            HIGH: begin
                fr0 = 1'b1;
                if (s == 3'b100) begin
                    next_state = MID;
                end else if (s == 3'b111) begin
                    next_state = ABOVE;
                end else begin
                    next_state = HIGH;
                end
            end
            MID: begin
                fr0 = 1'b1;
                fr1 = 1'b1;
                if (s == 3'b000) begin
                    next_state = LOW;
                end else if (s == 3'b110) begin
                    next_state = HIGH;
                end else begin
                    next_state = MID;
                end
            end
            LOW: begin
                fr0 = 1'b1;
                fr1 = 1'b1;
                fr2 = 1'b1;
                dfr = 1'b1;
                if (s == 3'b001) begin
                    next_state = MID;
                end else begin
                    next_state = LOW;
                end
            end
            default: begin
                next_state = LOW;
            end
        endcase
    end

endmodule