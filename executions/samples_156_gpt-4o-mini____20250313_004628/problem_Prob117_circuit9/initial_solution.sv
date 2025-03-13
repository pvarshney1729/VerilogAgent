module TopModule (
    input logic clk,
    input logic a,
    output logic [2:0] q
);
    logic [2:0] state;

    always @(posedge clk) begin
        if (state == 3'b000 && a == 1'b1) begin
            state <= 3'b000;
        end else if (state == 3'b000 && a == 1'b0) begin
            state <= 3'b001;
        end else if (state == 3'b001 && a == 1'b1) begin
            state <= 3'b010;
        end else if (state == 3'b001 && a == 1'b0) begin
            state <= 3'b001;
        end else if (state == 3'b010 && a == 1'b1) begin
            state <= 3'b011;
        end else if (state == 3'b010 && a == 1'b0) begin
            state <= 3'b010;
        end else if (state == 3'b011 && a == 1'b1) begin
            state <= 3'b100;
        end else if (state == 3'b011 && a == 1'b0) begin
            state <= 3'b011;
        end else if (state == 3'b100 && a == 1'b1) begin
            state <= 3'b101;
        end else if (state == 3'b100 && a == 1'b0) begin
            state <= 3'b000;
        end else if (state == 3'b101 && a == 1'b1) begin
            state <= 3'b110;
        end else if (state == 3'b101 && a == 1'b0) begin
            state <= 3'b101;
        end else if (state == 3'b110 && a == 1'b1) begin
            state <= 3'b111;
        end else if (state == 3'b110 && a == 1'b0) begin
            state <= 3'b110;
        end else if (state == 3'b111 && a == 1'b1) begin
            state <= 3'b000;
        end else if (state == 3'b111 && a == 1'b0) begin
            state <= 3'b111;
        end
    end

    assign q = state;

endmodule