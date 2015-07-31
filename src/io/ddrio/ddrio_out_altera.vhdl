-- EMACS settings: -*-  tab-width: 2; indent-tabs-mode: t -*-
-- vim: tabstop=2:shiftwidth=2:noexpandtab
-- kate: tab-width 2; replace-tabs off; indent-width 2;
-- 
-- ============================================================================
-- Authors:					Martin Zabel
--									Patrick Lehmann
-- 
-- Module:					Instantiates Chip-Specific DDR Output Registers for Altera FPGAs.
--
-- Description:
-- ------------------------------------
--	See PoC.io.ddrio.out for interface description.
--		
-- License:
-- ============================================================================
-- Copyright 2007-2015 Technische Universitaet Dresden - Germany,
--										 Chair for VLSI-Design, Diagnostics and Architecture
-- 
-- Licensed under the Apache License, Version 2.0 (the "License");
-- you may not use this file except in compliance with the License.
-- You may obtain a copy of the License at
-- 
--		http://www.apache.org/licenses/LICENSE-2.0
-- 
-- Unless required by applicable law or agreed to in writing, software
-- distributed under the License is distributed on an "AS IS" BASIS,
-- WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
-- See the License for the specific language governing permissions and
-- limitations under the License.
-- ============================================================================

library	IEEE;
use			IEEE.std_logic_1164.ALL;

library	Altera_mf;
use			Altera_mf.Altera_MF_Components.all;


entity ddrio_out_altera is
	generic (
		BITS								: POSITIVE
	);
	port (
		Clock					: in	STD_LOGIC;
		ClockEnable		: in	STD_LOGIC;
		OutputEnable	: in	STD_LOGIC;		
		DataOut_high	: in	STD_LOGIC_VECTOR(BITS - 1 downto 0);
		DataOut_low		: in	STD_LOGIC_VECTOR(BITS - 1 downto 0);
		Pad						: out	STD_LOGIC_VECTOR(BITS - 1 downto 0)
	);
end entity;


architecture rtl of ddrio_out_altera is

begin
	off : altddio_out
		generic map (
			WIDTH										=> BITS,
			INTENDED_DEVICE_FAMILY	=> "STRATIXII"		-- TODO: built device string from PoC.config information
		)
		port map (
			outclock		=> Clock,
			outclocken	=> ClockEnable,
			oe					=> OutputEnable,
			datain_h		=> DataOut_high,
			datain_l		=> DataOut_low,
			dataout			=> Pad
		);
end architecture;
