module jk_flip_flop (
    input logic clk,
    input logic reset,
    input logic J,
    input logic K,
    output logic Q,
    output logic Qn
);

    // Initialize Q and Qn
    initial begin
        Q = 1'b0;
        Qn = 1'b1;
    end

    always @(*) begin
        if (reset) begin
            Q = 1'b0;
            Qn = 1'b1;
        end else begin
            case ({J, K})
                2'b00: begin
                    // No change
                    Q = Q;
                    Qn = ~Q;
                end
                2'b01: begin
                    // Reset
                    Q = 1'b0;
                    Qn = 1'b1;
                end
                2'b10: begin
                    // Set
                    Q = 1'b1;
                    Qn = 1'b0;
                end
                2'b11: begin
                    // Toggle
                    Q = ~Q;
                    Qn = ~Qn;
                end
            endcase
        end
    end

    // Sequential logic to update Q on clock edge
    always @(posedge clk) begin
        // Update Q and Qn based on the combinational logic
        Q <= Q;
        Qn <= ~Q;
    end

endmodule