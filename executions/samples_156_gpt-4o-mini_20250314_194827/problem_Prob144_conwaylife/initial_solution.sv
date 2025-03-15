module game_of_life (
    input logic clk,
    input logic reset,
    input logic load,
    input logic [255:0] init_data,
    output logic [255:0] current_state
);

    logic [255:0] state;

    always @(*) begin
        if (reset) begin
            state = 256'b0;
        end else if (load) begin
            state = init_data;
        end else begin
            logic [255:0] next_state;
            for (int i = 0; i < 256; i++) begin
                int live_neighbors = 0;
                for (int j = -1; j <= 1; j++) begin
                    for (int k = -1; k <= 1; k++) begin
                        if (j == 0 && k == 0) continue;
                        int neighbor_index = (i + j * 16 + k);
                        if (neighbor_index >= 0 && neighbor_index < 256) begin
                            live_neighbors += state[neighbor_index];
                        end
                    end
                end
                next_state[i] = (state[i] && (live_neighbors == 2 || live_neighbors == 3)) || 
                                 (!state[i] && live_neighbors == 3);
            end
            state = next_state;
        end
    end

    assign current_state = state;

endmodule