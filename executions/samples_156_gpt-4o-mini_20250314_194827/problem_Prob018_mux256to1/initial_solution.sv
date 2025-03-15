module mux256to1 (
    input logic [255:0] data,
    input logic [7:0] sel,
    output logic out
);

    always @(*) begin
        if (sel < 8'd256) begin
            out = data[sel];
        end else begin
            out = 1'b0; // Define behavior for out-of-range 'sel' values
        end
    end

endmodule