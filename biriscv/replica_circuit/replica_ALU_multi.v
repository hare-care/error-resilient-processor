//one invertor delay: 0.123859,  critical path: 3.394
module inverter(input wire a, output wire y);
    not (y, a);
endmodule
module replica_ALU(input wire A, output wire Y);
    wire [26:0] interconnections; // Wires to connect inverters

    // Instantiate 28 inverters and chain them
    inverter inv0(A, interconnections[0]);
    inverter inv1(interconnections[0], interconnections[1]);
    inverter inv2(interconnections[1], interconnections[2]);
    inverter inv3(interconnections[2], interconnections[3]);
    inverter inv4(interconnections[3], interconnections[4]);
    inverter inv5(interconnections[4], interconnections[5]);
    inverter inv6(interconnections[5], interconnections[6]);
    inverter inv7(interconnections[6], interconnections[7]);
    inverter inv8(interconnections[7], interconnections[8]);
    inverter inv9(interconnections[8], interconnections[9]);
    inverter inv10(interconnections[9], interconnections[10]);
    inverter inv11(interconnections[10], interconnections[11]);
    inverter inv12(interconnections[11], interconnections[12]);
    inverter inv13(interconnections[12], interconnections[13]);
    inverter inv14(interconnections[13], interconnections[14]);
    inverter inv15(interconnections[14], interconnections[15]);
    inverter inv16(interconnections[15], interconnections[16]);
    inverter inv17(interconnections[16], interconnections[17]);
    inverter inv18(interconnections[17], interconnections[18]);
    inverter inv19(interconnections[18], interconnections[19]);
    inverter inv20(interconnections[19], interconnections[20]);
    inverter inv21(interconnections[20], interconnections[21]);
    inverter inv22(interconnections[21], interconnections[22]);
    inverter inv23(interconnections[22], interconnections[23]);
    inverter inv24(interconnections[23], interconnections[24]);
    inverter inv25(interconnections[24], interconnections[25]);
    inverter inv26(interconnections[25], interconnections[26]);
    inverter inv27(interconnections[26], Y);
endmodule



