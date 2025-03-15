module bcd_counter (
    input logic clk,
    input logic rst_n,
    input logic enable,
    output logic [15:0] count
);

    logic [15:0] count_next;

    always @(*) begin
        if (!rst_n) begin
            count_next = 16'b0;
        end else if (enable) begin
            if (count == 16'd9999) begin
                count_next = 16'b0;
            end else if (count[3:0] == 4'd9) begin
                if (count[7:4] == 4'd9) begin
                    if (count[11:8] == 4'd9) begin
                        count_next = count + 16'd1;
                    end else begin
                        count_next = {count[15:12], count[11:8] + 4'd1, 4'b0};
                    end
                end else begin
                    count_next = {count[15:8], count[7:4] + 4'd1, 4'b0};
                end
            end else begin
                count_next = count + 16'd1;
            end
        end else begin
            count_next = count;
        end
    end

    always @(posedge clk) begin
        if (!rst_n) begin
            count <= 16'b0;
        end else if (enable) begin
            count <= count_next;
        end
    end

endmodule