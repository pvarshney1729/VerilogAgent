module TopModule(
    input logic clk,
    input logic rst,
    input logic load,
    input logic [255:0] data,
    output logic [255:0] q
);

    logic [255:0] next_q;

    always_ff @(posedge clk) begin
        if (rst) begin
            q <= 256'b0;
        end else if (load) begin
            q <= data;
        end else begin
            q <= next_q;
        end
    end

    always_comb begin
        for (int i = 0; i < 16; i++) begin
            for (int j = 0; j < 16; j++) begin
                int count = 0;
                // Calculate neighbors with toroidal wrapping
                count += q[((i-1) & 4'hF) * 16 + ((j-1) & 4'hF)];
                count += q[((i-1) & 4'hF) * 16 + j];
                count += q[((i-1) & 4'hF) * 16 + ((j+1) & 4'hF)];
                count += q[i * 16 + ((j-1) & 4'hF)];
                count += q[i * 16 + ((j+1) & 4'hF)];
                count += q[((i+1) & 4'hF) * 16 + ((j-1) & 4'hF)];
                count += q[((i+1) & 4'hF) * 16 + j];
                count += q[((i+1) & 4'hF) * 16 + ((j+1) & 4'hF)];

                // Apply state transition rules
                if (count == 3 || (count == 2 && q[i * 16 + j])) begin
                    next_q[i * 16 + j] = 1;
                end else begin
                    next_q[i * 16 + j] = 0;
                end
            end
        end
    end

endmodule