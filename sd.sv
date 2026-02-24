module seq_detector_1011 (
    input  logic clk,
    input  logic rst,
    input  logic din,
    output logic detect
);

    typedef enum logic [2:0] {
        S0, S1, S10, S101, S1011
    } state_t;

    state_t state, next_state;

    // State register
    always_ff @(posedge clk) begin
        if (rst)
            state <= S0;
        else
            state <= next_state;
    end

    // Next-state logic
    always_comb begin
        next_state = state;
        case (state)
            S0:    next_state = din ? S1   : S0;
            S1:    next_state = din ? S1   : S10;
            S10:   next_state = din ? S101 : S0;
            S101:  next_state = din ? S1011: S10;
            S1011: next_state = din ? S1   : S10;
        endcase
    end

    // Output logic
    always_comb begin
        detect = (state == S1011);
    end

endmodule
