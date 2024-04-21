// input external delay: 4 ns
// in delay: 0.011365 ns
// input delay: 0.010861 ns
// output delay: 0.175128 ns
// out delay: 0.000627 ns
// total extra delay: 4.197981 ns
// critical path time: 4.764360 ns
// total inverter delay needed: 4.764360 - 4.197981 = 0.566379 ns
// average one inverter delay: 0.03012 ns
// inverters needed: 14

module inverter(input wire a, output wire y);
    not (y, a);
endmodule

module frontend_replica(input wire in, output wire out);
	wire [12:0] interconnections; // Wires to connect inverters

    // Instantiate 14 inverters and chain them
	inverter inv0(in, interconnections[0]);
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
	inverter inv13(interconnections[12], out);
endmodule