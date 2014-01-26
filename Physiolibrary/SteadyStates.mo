within Physiolibrary;
package SteadyStates "Dynamic Simulation / Steady State"
  extends Modelica.Icons.BasesPackage;
  package Examples
    "Examples that demonstrate usage of the Pressure flow components"
  extends Modelica.Icons.ExamplesPackage;
    model SimpleReaction_in_Equilibrium
      extends Modelica.Icons.Example;

      import Physiolibrary.Types.*;

      SteadyStates.Components.MolarConservationLaw
        amountOfSubstanceConservationLaw(
        n=2,
        Total(displayUnit="mol") = 1,
        Simulation=SimulationType.SteadyState)
        annotation (Placement(transformation(extent={{68,-44},{88,-24}})));
      Chemical.Components.Substance A(Simulation=SimulationType.SteadyState,
          solute_start=0.9)
        annotation (Placement(transformation(extent={{-58,-10},{-38,10}})));
      Chemical.Components.ChemicalReaction reaction(K=1)
        annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
      Chemical.Components.Substance B(
        Simulation=SimulationType.SteadyState,
        isDependent=true,
        solute_start=0.1)
        annotation (Placement(transformation(extent={{42,-10},{62,10}})));

    equation
      connect(A.solute, amountOfSubstanceConservationLaw.fragment[1]) annotation (
          Line(
          points={{-48,-10},{-48,-39},{68,-39}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(B.solute, amountOfSubstanceConservationLaw.fragment[2]) annotation (
          Line(
          points={{52,-10},{52,-37},{68,-37}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(B.q_out,reaction. products[1]) annotation (Line(
          points={{52,0},{10,0}},
          color={107,45,134},
          thickness=1,
          smooth=Smooth.None));
      connect(A.q_out,reaction. substrates[1]) annotation (Line(
          points={{-48,0},{-10,0}},
          color={107,45,134},
          thickness=1,
          smooth=Smooth.None));
      annotation (Documentation(revisions="<html>
<p><i>2013</i></p>
<p>Marek Matejak, Charles University, Prague, Czech Republic </p>
</html>"),     Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
                {100,100}}), graphics));
    end SimpleReaction_in_Equilibrium;

    model SimpleReaction2_in_Equilibrium
    extends Modelica.Icons.Example;
      import Physiolibrary.Types.*;

      Chemical.Components.Substance A(Simulation=SimulationType.SteadyState,
          solute_start=0.9)
        annotation (Placement(transformation(extent={{-68,-8},{-48,12}})));
      Chemical.Components.ChemicalReaction reaction(K=1, nP=2)
        annotation (Placement(transformation(extent={{-34,-8},{-14,12}})));
      Chemical.Components.Substance B(
        Simulation=SimulationType.SteadyState,
        isDependent=true,
        solute_start=0.1)
        annotation (Placement(transformation(extent={{2,-10},{22,10}})));

      Chemical.Components.Substance C(
        Simulation=SimulationType.SteadyState,
        isDependent=true,
        solute_start=0.1)
        annotation (Placement(transformation(extent={{2,18},{22,38}})));

      Components.MolarConservationLaw totalB_ConservationLaw(
        n=2,
        Total(displayUnit="mol") = 1,
        Simulation=SimulationType.SteadyState)
        annotation (Placement(transformation(extent={{34,-10},{54,10}})));
      Components.MolarConservationLaw totalC_ConservationLaw(
        n=2,
        Total(displayUnit="mol") = 1,
        Simulation=SimulationType.SteadyState)
        annotation (Placement(transformation(extent={{34,18},{54,38}})));
    equation
      connect(A.q_out,reaction. substrates[1]) annotation (Line(
          points={{-58,2},{-34,2}},
          color={107,45,134},
          thickness=1,
          smooth=Smooth.None));
      connect(reaction.products[1],B. q_out) annotation (Line(
          points={{-14,1.5},{-4,1.5},{-4,0},{12,0}},
          color={107,45,134},
          thickness=1,
          smooth=Smooth.None));
      connect(reaction.products[2],C. q_out) annotation (Line(
          points={{-14,2.5},{-4,2.5},{-4,28},{12,28}},
          color={107,45,134},
          thickness=1,
          smooth=Smooth.None));
      connect(A.solute, totalB_ConservationLaw.fragment[1])           annotation (
          Line(
          points={{-58,-8},{-58,-16},{26,-16},{26,-5},{34,-5}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(B.solute, totalB_ConservationLaw.fragment[2])           annotation (
          Line(
          points={{12,-10},{12,-14},{24,-14},{24,-3},{34,-3}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(C.solute, totalC_ConservationLaw.fragment[1]) annotation (Line(
          points={{12,18},{12,14},{26,14},{26,23},{34,23}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(A.solute, totalC_ConservationLaw.fragment[2]) annotation (Line(
          points={{-58,-8},{-58,-16},{-70,-16},{-70,40},{26,40},{26,25},{34,25}},
          color={0,0,127},
          smooth=Smooth.None));

      annotation (Documentation(revisions="<html>
<p><i>2013</i></p>
<p>Marek Matejak, Charles University, Prague, Czech Republic </p>
</html>"), Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics));
    end SimpleReaction2_in_Equilibrium;

    model O2_in_water
    extends Modelica.Icons.Example;
      import Physiolibrary.Types.*;

    public
      Chemical.Components.Substance oxygen_dissolved(
                                                    Simulation=SimulationType.SteadyState,
          solute_start=0.000001*7.875647668393782383419689119171e-5,
        isDependent=true)
        annotation (Placement(transformation(extent={{-12,-56},{8,-36}})));
      Modelica.Blocks.Sources.Clock oxygenPartialPressure(offset=1e-06)
        annotation (Placement(transformation(extent={{-80,60},{-60,80}})));
      Modelica.Blocks.Sources.Sine temperature(
        amplitude=10,
        freqHz=1/60,
        offset=310.15)
        annotation (Placement(transformation(extent={{-94,-28},{-74,-8}})));
      Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature
        prescribedTemperature
        annotation (Placement(transformation(extent={{-56,-28},{-36,-8}})));
      Chemical.Components.GasSolubility gasSolubility(useHeatPort=true, kH_T0=1
            /(0.0105*(1e-3)*Modelica.Constants.R*298.15))
        annotation (Placement(transformation(extent={{-12,-28},{8,-8}})));
      Chemical.Sources.UnlimitedGasStorage unlimitedGasStorage(T=295.15,
          Simulation=Physiolibrary.Types.SimulationType.SteadyState)
        annotation (Placement(transformation(extent={{-40,60},{-20,80}})));
    equation

      connect(temperature.y, prescribedTemperature.T) annotation (Line(
          points={{-73,-18},{-58,-18}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(oxygen_dissolved.q_out, gasSolubility.q_in) annotation (Line(
          points={{-2,-46},{-2,-26}},
          color={107,45,134},
          thickness=1,
          smooth=Smooth.None));
      connect(prescribedTemperature.port, gasSolubility.heatPort) annotation (
          Line(
          points={{-36,-18},{-2,-18}},
          color={191,0,0},
          smooth=Smooth.None));
      connect(oxygenPartialPressure.y, unlimitedGasStorage.partialPressure)
        annotation (Line(
          points={{-59,70},{-40,70}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(unlimitedGasStorage.q_out, gasSolubility.q_out) annotation (Line(
          points={{-20,70},{-2,70},{-2,-8}},
          color={107,45,134},
          thickness=1,
          smooth=Smooth.None));
      annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics),
        experiment(StopTime=100),
        __Dymola_experimentSetupOutput,
        Documentation(info="<html>
<p>Partial pressure of oxygen in air is the air pressure multiplied by the fraction of the oxygen in air. Oxygen solubility</p>
</html>", revisions="<html>
<p><i>2013</i></p>
<p>Marek Matejak, Charles University, Prague, Czech Republic </p>
</html>"));
    end O2_in_water;

    model Allosteric_Hemoglobin_MWC
    extends Modelica.Icons.Example;
      import Physiolibrary.Chemical;
      import Physiolibrary.Types.*;

    //extends Physiolibrary.SteadyStates.Interfaces.SteadyStateSystem(
    //                                         Simulation=SteadyStates.SimulationType.SteadyState);
    //=States.SimulationType.NoInit); for dynamic simulation
    protected
      parameter Physiolibrary.Types.GasSolubility alpha =  0.0105 * 1e-3
        "oxygen solubility in plasma"; // by Siggaard Andersen: 0.0105 (mmol/l)/kPa
      parameter Physiolibrary.Types.Fraction L = 7.0529*10^6
        "=[T0]/[R0] .. dissociation constant of relaxed <-> tensed change of deoxyhemoglobin tetramer";
      parameter Physiolibrary.Types.Fraction c = 0.00431555
        "=KR/KT .. ration between oxygen affinities of relaxed vs. tensed subunit";
      parameter Physiolibrary.Types.Concentration KR = 0.000671946
        "oxygen dissociation on relaxed(R) hemoglobin subunit";   //*7.875647668393782383419689119171e-5
                                                                //10.500001495896 7.8756465463794e-05

      parameter Physiolibrary.Types.Concentration KT=KR/c
        "oxygen dissociation on tensed(T) hemoglobin subunit";
    //  Physiolibrary.Types.Fraction sO2 "hemoglobin oxygen saturation";

    //  parameter Physiolibrary.Types.AmountOfSubstance totalAmountOfHemoglobin=1;
    //  Physiolibrary.Types.AmountOfSubstance totalAmountOfRforms;
    //  Physiolibrary.Types.AmountOfSubstance totalAmountOfTforms;

    public
      Chemical.Components.Substance T0(
        stateName="T0",
        Simulation=SimulationType.SteadyState,
        solute_start=1)
        annotation (Placement(transformation(extent={{32,78},{52,98}})));

      Chemical.Components.Substance T1(
        stateName="T1",
        Simulation=SimulationType.SteadyState,
        solute_start=0)
        annotation (Placement(transformation(extent={{34,36},{54,56}})));

      Chemical.Components.Substance R1(
        stateName="R1",
        Simulation=SimulationType.SteadyState,
        solute_start=0,
        isDependent=true)
        annotation (Placement(transformation(extent={{-20,36},{0,56}})));

      Chemical.Components.Substance T2(
        stateName="T2",
        Simulation=SimulationType.SteadyState,
        solute_start=0)
        annotation (Placement(transformation(extent={{34,-10},{54,10}})));

      Chemical.Components.Substance R2(
        stateName="R2",
        Simulation=SimulationType.SteadyState,
        solute_start=0)
        annotation (Placement(transformation(extent={{-20,-10},{0,10}})));

      Chemical.Components.Substance T3(
        stateName="T3",
        Simulation=SimulationType.SteadyState,
        solute_start=0)
        annotation (Placement(transformation(extent={{34,-54},{54,-34}})));

      Chemical.Components.Substance R3(
        stateName="R3",
        Simulation=SimulationType.SteadyState,
        solute_start=0)
        annotation (Placement(transformation(extent={{-20,-54},{0,-34}})));

      Chemical.Components.Substance T4(
        stateName="T4",
        Simulation=SimulationType.SteadyState,
        solute_start=0,
        isDependent=true)
        annotation (Placement(transformation(extent={{34,-92},{54,-72}})));

      Chemical.Components.Substance R4(
        stateName="R4",
        Simulation=SimulationType.SteadyState,
        solute_start=0)
        annotation (Placement(transformation(extent={{-20,-92},{0,-72}})));

      Chemical.Components.Substance R0(
        stateName="R0",
        Simulation=SimulationType.SteadyState,
        solute_start=0)
        annotation (Placement(transformation(extent={{-20,78},{0,98}})));

      Chemical.Components.ChemicalReaction quaternaryForm(K=L)
        annotation (Placement(transformation(extent={{4,78},{24,98}})));
      Chemical.Components.ChemicalReaction oxyR1(nP=2, K=KR/4)  annotation (Placement(
            transformation(
            extent={{-10,10},{10,-10}},
            rotation=90,
            origin={-10,64})));
      Chemical.Components.ChemicalReaction oxyT1(nP=2, K=KT/4)  annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={44,64})));
      Chemical.Components.ChemicalReaction oxyR2(nP=2, K=KR/(3/2))
                                                                annotation (Placement(
            transformation(
            extent={{-10,10},{10,-10}},
            rotation=90,
            origin={-10,22})));
      Chemical.Components.ChemicalReaction oxyR3(nP=2, K=KR/(2/3))
                                                                annotation (Placement(
            transformation(
            extent={{-10,10},{10,-10}},
            rotation=90,
            origin={-10,-24})));
      Chemical.Components.ChemicalReaction oxyR4(nP=2, K=KR*4)  annotation (Placement(
            transformation(
            extent={{-10,10},{10,-10}},
            rotation=90,
            origin={-10,-66})));
      Chemical.Components.ChemicalReaction oxyT2(nP=2, K=KT/(3/2))
                                                                annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={44,22})));
      Chemical.Components.ChemicalReaction oxyT3(nP=2, K=KT/(2/3))
                                                                annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={44,-24})));
      Chemical.Components.ChemicalReaction oxyT4(nP=2, K=KT*4)  annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={44,-66})));
      Chemical.Components.ChemicalReaction quaternaryForm1(K=c*L)
        annotation (Placement(transformation(extent={{8,36},{28,56}})));
      Chemical.Components.ChemicalReaction quaternaryForm2(K=(c^2)*L)
        annotation (Placement(transformation(extent={{8,-10},{28,10}})));
      Chemical.Components.ChemicalReaction quaternaryForm3(K=(c^3)*L)
        annotation (Placement(transformation(extent={{8,-54},{28,-34}})));
      Chemical.Components.ChemicalReaction quaternaryForm4(K=(c^4)*L)
        annotation (Placement(transformation(extent={{10,-92},{30,-72}})));

      Chemical.Components.Substance oxygen_unbound(solute_start=0.000001*
            7.875647668393782383419689119171e-5, Simulation=SimulationType.SteadyState)
        annotation (Placement(transformation(extent={{-56,-36},{-36,-16}})));
      Modelica.Blocks.Sources.Clock clock(offset=60)
        annotation (Placement(transformation(extent={{-94,52},{-74,72}})));
      SteadyStates.Components.MolarConservationLaw hemoglobinConservationLaw(
        n=10, Total(displayUnit="mol") = 1,
        Simulation=Physiolibrary.Types.SimulationType.SteadyState)
        annotation (Placement(transformation(extent={{72,-2},{92,18}})));

      Chemical.Sources.UnlimitedGasStorage O2_in_air(Simulation=Physiolibrary.Types.SimulationType.SteadyState,
        T=295.15,
        usePartialPressureInput=true)
                    annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={-66,32})));
      Chemical.Components.GasSolubility gasSolubility(kH_T0=1/(0.0105*(1e-3)*
            Modelica.Constants.R*298.15), useHeatPort=false)
        annotation (Placement(transformation(extent={{-76,-6},{-56,14}})));
      Modelica.Blocks.Math.Sum oxygen_bound(k={1,1,2,2,3,3,4,4}, nin=8)
        annotation (Placement(transformation(extent={{72,-56},{82,-46}})));
      Modelica.Blocks.Math.Division sO2_ "hemoglobin oxygen saturation"
        annotation (Placement(transformation(extent={{86,-60},{96,-50}})));
      Modelica.Blocks.Math.Sum tHb(nin=10, k=4*ones(10))
        annotation (Placement(transformation(extent={{72,-70},{82,-60}})));
    equation
     // sO2 = (R1.solute + 2*R2.solute + 3*R3.solute + 4*R4.solute + T1.solute + 2*T2.solute + 3*T3.solute + 4*T4.solute)/(4*hemoglobinConservationLaw.Total);
     // totalAmountOfRforms = R0.solute + R1.solute + R2.solute + R3.solute + R4.solute;
     //  totalAmountOfTforms = T0.solute + T1.solute + T2.solute + T3.solute + T4.solute;

     //  totalAmountOfHemoglobin*normalizedState[1] = totalAmountOfRforms + totalAmountOfTforms;

      connect(quaternaryForm.products[1],T0. q_out) annotation (Line(
          points={{24,88},{42,88}},
          color={107,45,134},
          thickness=1,
          smooth=Smooth.None));
      connect(oxyR1.products[2], oxygen_unbound.q_out)
                                          annotation (Line(
          points={{-9.5,74},{-46,74},{-46,-26}},
          color={107,45,134},
          thickness=1,
          smooth=Smooth.None));
      connect(oxyR2.products[2], oxygen_unbound.q_out)
                                          annotation (Line(
          points={{-9.5,32},{-46,32},{-46,-26}},
          color={107,45,134},
          thickness=1,
          smooth=Smooth.None));
      connect(oxyR3.products[2], oxygen_unbound.q_out)
                                          annotation (Line(
          points={{-9.5,-14},{-46,-14},{-46,-26}},
          color={107,45,134},
          thickness=1,
          smooth=Smooth.None));
      connect(oxyR4.products[2], oxygen_unbound.q_out)
                                          annotation (Line(
          points={{-9.5,-56},{-46,-56},{-46,-26}},
          color={107,45,134},
          thickness=1,
          smooth=Smooth.None));
      connect(oxyR1.substrates[1],R1. q_out) annotation (Line(
          points={{-10,54},{-10,46}},
          color={107,45,134},
          thickness=1,
          smooth=Smooth.None));
      connect(R1.q_out,oxyR2. products[1]) annotation (Line(
          points={{-10,46},{-10,32},{-10.5,32}},
          color={107,45,134},
          thickness=1,
          smooth=Smooth.None));
      connect(oxyR2.substrates[1],R2. q_out) annotation (Line(
          points={{-10,12},{-10,0}},
          color={107,45,134},
          thickness=1,
          smooth=Smooth.None));
      connect(oxyR3.substrates[1],R3. q_out) annotation (Line(
          points={{-10,-34},{-10,-44}},
          color={107,45,134},
          thickness=1,
          smooth=Smooth.None));
      connect(oxyR3.products[1],R2. q_out) annotation (Line(
          points={{-10.5,-14},{-10.5,-7},{-10,-7},{-10,0}},
          color={107,45,134},
          thickness=1,
          smooth=Smooth.None));
      connect(R3.q_out,oxyR4. products[1]) annotation (Line(
          points={{-10,-44},{-10,-56},{-10.5,-56}},
          color={107,45,134},
          thickness=1,
          smooth=Smooth.None));
      connect(oxyR4.substrates[1],R4. q_out) annotation (Line(
          points={{-10,-76},{-10,-82}},
          color={107,45,134},
          thickness=1,
          smooth=Smooth.None));
      connect(oxyT1.products[1],T0. q_out) annotation (Line(
          points={{44.5,74},{44.5,88},{42,88}},
          color={107,45,134},
          thickness=1,
          smooth=Smooth.None));
      connect(oxyT1.substrates[1],T1. q_out) annotation (Line(
          points={{44,54},{44,46}},
          color={107,45,134},
          thickness=1,
          smooth=Smooth.None));
      connect(oxygen_unbound.q_out, oxyT1.products[2])
                                          annotation (Line(
          points={{-46,-26},{-46,74},{43.5,74}},
          color={107,45,134},
          thickness=1,
          smooth=Smooth.None));
      connect(oxygen_unbound.q_out, oxyT2.products[2])
                                          annotation (Line(
          points={{-46,-26},{-46,32},{43.5,32}},
          color={107,45,134},
          thickness=1,
          smooth=Smooth.None));
      connect(oxygen_unbound.q_out, oxyT3.products[2])
                                          annotation (Line(
          points={{-46,-26},{-46,-14},{43.5,-14}},
          color={107,45,134},
          thickness=1,
          smooth=Smooth.None));
      connect(oxygen_unbound.q_out, oxyT4.products[2])
                                          annotation (Line(
          points={{-46,-26},{-46,-56},{43.5,-56}},
          color={107,45,134},
          thickness=1,
          smooth=Smooth.None));
      connect(T1.q_out,oxyT2. products[1]) annotation (Line(
          points={{44,46},{44,32},{44.5,32}},
          color={107,45,134},
          thickness=1,
          smooth=Smooth.None));
      connect(oxyT2.substrates[1],T2. q_out) annotation (Line(
          points={{44,12},{44,0}},
          color={107,45,134},
          thickness=1,
          smooth=Smooth.None));
      connect(T2.q_out,oxyT3. products[1]) annotation (Line(
          points={{44,0},{44,-14},{44.5,-14}},
          color={107,45,134},
          thickness=1,
          smooth=Smooth.None));
      connect(oxyT3.substrates[1],T3. q_out) annotation (Line(
          points={{44,-34},{44,-44}},
          color={107,45,134},
          thickness=1,
          smooth=Smooth.None));
      connect(T3.q_out,oxyT4. products[1]) annotation (Line(
          points={{44,-44},{44,-56},{44.5,-56}},
          color={107,45,134},
          thickness=1,
          smooth=Smooth.None));
      connect(oxyT4.substrates[1],T4. q_out) annotation (Line(
          points={{44,-76},{44,-82}},
          color={107,45,134},
          thickness=1,
          smooth=Smooth.None));
      connect(R0.q_out,quaternaryForm. substrates[1]) annotation (Line(
          points={{-10,88},{4,88}},
          color={107,45,134},
          thickness=1,
          smooth=Smooth.None));
      connect(R0.q_out,oxyR1. products[1]) annotation (Line(
          points={{-10,88},{-10,74},{-10.5,74}},
          color={107,45,134},
          thickness=1,
          smooth=Smooth.None));
      connect(R1.q_out,quaternaryForm1. substrates[1]) annotation (Line(
          points={{-10,46},{8,46}},
          color={107,45,134},
          thickness=1,
          smooth=Smooth.None));
      connect(quaternaryForm1.products[1],T1. q_out) annotation (Line(
          points={{28,46},{44,46}},
          color={107,45,134},
          thickness=1,
          smooth=Smooth.None));
      connect(R2.q_out,quaternaryForm2. substrates[1]) annotation (Line(
          points={{-10,0},{8,0}},
          color={107,45,134},
          thickness=1,
          smooth=Smooth.None));
      connect(quaternaryForm2.products[1],T2. q_out) annotation (Line(
          points={{28,0},{44,0}},
          color={107,45,134},
          thickness=1,
          smooth=Smooth.None));
      connect(R3.q_out,quaternaryForm3. substrates[1]) annotation (Line(
          points={{-10,-44},{8,-44}},
          color={107,45,134},
          thickness=1,
          smooth=Smooth.None));
      connect(quaternaryForm3.products[1],T3. q_out) annotation (Line(
          points={{28,-44},{44,-44}},
          color={107,45,134},
          thickness=1,
          smooth=Smooth.None));
      connect(R4.q_out,quaternaryForm4. substrates[1]) annotation (Line(
          points={{-10,-82},{10,-82}},
          color={107,45,134},
          thickness=1,
          smooth=Smooth.None));
      connect(quaternaryForm4.products[1],T4. q_out) annotation (Line(
          points={{30,-82},{44,-82}},
          color={107,45,134},
          thickness=1,
          smooth=Smooth.None));
      connect(R4.solute, hemoglobinConservationLaw.fragment[1])        annotation (
          Line(
          points={{-10,-92},{-10,-98},{64,-98},{64,2.2},{72,2.2}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(T4.solute, hemoglobinConservationLaw.fragment[2])        annotation (
          Line(
          points={{44,-92},{44,-98},{64,-98},{64,2.6},{72,2.6}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(R3.solute, hemoglobinConservationLaw.fragment[3])        annotation (
          Line(
          points={{-10,-54},{64,-54},{64,3},{72,3}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(T3.solute, hemoglobinConservationLaw.fragment[4])        annotation (
          Line(
          points={{44,-54},{64,-54},{64,3.4},{72,3.4}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(R2.solute, hemoglobinConservationLaw.fragment[5])        annotation (
          Line(
          points={{-10,-10},{64,-10},{64,3.8},{72,3.8}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(T2.solute, hemoglobinConservationLaw.fragment[6])        annotation (
          Line(
          points={{44,-10},{64,-10},{64,4.2},{72,4.2}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(R1.solute, hemoglobinConservationLaw.fragment[7])        annotation (
          Line(
          points={{-10,36},{64,36},{64,4.6},{72,4.6}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(T1.solute, hemoglobinConservationLaw.fragment[8])        annotation (
          Line(
          points={{44,36},{64,36},{64,5},{72,5}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(R0.solute, hemoglobinConservationLaw.fragment[9])        annotation (
          Line(
          points={{-10,78},{64,78},{64,5.4},{72,5.4}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(T0.solute, hemoglobinConservationLaw.fragment[10])        annotation (
         Line(
          points={{42,78},{64,78},{64,5.8},{72,5.8}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(oxygen_unbound.q_out, gasSolubility.q_in) annotation (Line(
          points={{-46,-26},{-66,-26},{-66,-4}},
          color={107,45,134},
          thickness=1,
          smooth=Smooth.None));
      connect(O2_in_air.q_out, gasSolubility.q_out) annotation (Line(
          points={{-66,22},{-66,14}},
          color={107,45,134},
          thickness=1,
          smooth=Smooth.None));
      connect(clock.y, O2_in_air.partialPressure) annotation (Line(
          points={{-73,62},{-66,62},{-66,42}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(R1.solute, oxygen_bound.u[1]) annotation (Line(
          points={{-10,36},{64,36},{64,-51.875},{71,-51.875}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(T1.solute, oxygen_bound.u[2]) annotation (Line(
          points={{44,36},{64,36},{64,-51.625},{71,-51.625}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(R2.solute, oxygen_bound.u[3]) annotation (Line(
          points={{-10,-10},{64,-10},{64,-51.375},{71,-51.375}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(T2.solute, oxygen_bound.u[4]) annotation (Line(
          points={{44,-10},{64,-10},{64,-51.125},{71,-51.125}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(R3.solute, oxygen_bound.u[5]) annotation (Line(
          points={{-10,-54},{64,-54},{64,-50.875},{71,-50.875}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(T3.solute, oxygen_bound.u[6]) annotation (Line(
          points={{44,-54},{64,-54},{64,-50.625},{71,-50.625}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(R4.solute, oxygen_bound.u[7]) annotation (Line(
          points={{-10,-92},{-10,-98},{64,-98},{64,-50.375},{71,-50.375}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(T4.solute, oxygen_bound.u[8]) annotation (Line(
          points={{44,-92},{44,-98},{64,-98},{64,-50.125},{71,-50.125}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(oxygen_bound.y, sO2_.u1) annotation (Line(
          points={{82.5,-51},{84,-51},{84,-52},{85,-52}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(sO2_.u2, tHb.y) annotation (Line(
          points={{85,-58},{84,-58},{84,-65},{82.5,-65}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(R0.solute, tHb.u[1]) annotation (Line(
          points={{-10,78},{64,78},{64,-65.9},{71,-65.9}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(T0.solute, tHb.u[2]) annotation (Line(
          points={{42,78},{64,78},{64,-65.7},{71,-65.7}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(R1.solute, tHb.u[3]) annotation (Line(
          points={{-10,36},{64,36},{64,-65.5},{71,-65.5}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(T1.solute, tHb.u[4]) annotation (Line(
          points={{44,36},{64,36},{64,-65.3},{71,-65.3}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(R2.solute, tHb.u[5]) annotation (Line(
          points={{-10,-10},{64,-10},{64,-65.1},{71,-65.1}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(T2.solute, tHb.u[6]) annotation (Line(
          points={{44,-10},{64,-10},{64,-64.9},{71,-64.9}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(R3.solute, tHb.u[7]) annotation (Line(
          points={{-10,-54},{64,-54},{64,-64.7},{71,-64.7}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(T3.solute, tHb.u[8]) annotation (Line(
          points={{44,-54},{64,-54},{64,-64.5},{71,-64.5}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(R4.solute, tHb.u[9]) annotation (Line(
          points={{-10,-92},{-10,-98},{64,-98},{64,-64.3},{71,-64.3}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(T4.solute, tHb.u[10]) annotation (Line(
          points={{44,-92},{44,-98},{64,-98},{64,-64.1},{71,-64.1}},
          color={0,0,127},
          smooth=Smooth.None));
      annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics),
        experiment(StopTime=10000),
        __Dymola_experimentSetupOutput,
        Documentation(info="<html>
<p>To understand the model is necessary to study the principles of MWC allosteric transitions first published by </p>
<p>Monod,Wyman,Changeux (1965). &QUOT;On the nature of allosteric transitions: a plausible model.&QUOT; Journal of molecular biology 12(1): 88-118.</p>
<p><br/>In short it is about binding oxygen to hemoglobin.</p>
<p>Oxgen are driven by its partial pressure using clock source - from very little pressure to pressure of 10kPa.</p>
<p>(Partial pressure of oxygen in air is the air pressure multiplied by the fraction of the oxygen in air.)</p>
<p>Hemoglobin was observed (by Perutz) in two structuraly different forms R and T.</p>
<p>These forms are represented by blocks T0..T4 and R0..R4, where the suffexed index means the number of oxygen bounded to the form.</p>
<p><br/>In equilibrated model can be four chemical reactions removed and the results will be the same, but dynamics will change a lot. ;)</p>
<p>If you remove the quaternaryForm1,quaternaryForm2,quaternaryForm3,quaternaryForm4 then the model in equilibrium will be exactly the same as in MWC article.</p>
<p><br/>Parameters was fitted to data of Severinghaus article from 1979. (For example at pO2=26mmHg is oxygen saturation sO2 = 48.27 &percnt;).</p>
</html>", revisions="<html>
<p><i>2013</i></p>
<p>Marek Matejak, Charles University, Prague, Czech Republic </p>
</html>"));
    end Allosteric_Hemoglobin_MWC;

    model Allosteric_Hemoglobin2_MWC
      "Allosteric hemoglobin model implemented by Speciation blocks"
      import Physiolibrary.Types.*;
     extends Modelica.Icons.Example;

      parameter Physiolibrary.Types.GasSolubility alpha =  0.0105 * 1e-3
        "oxygen solubility in plasma"; // by Siggaard Andersen: 0.0105 (mmol/l)/kPa
      parameter Physiolibrary.Types.Fraction L = 7.0529*10^6
        "=[T0]/[R0] .. dissociation constant of relaxed <-> tensed change of deoxyhemoglobin tetramer";
      parameter Physiolibrary.Types.Fraction c = 0.00431555
        "=KR/KT .. ration between oxygen affinities of relaxed vs. tensed subunit";
      parameter Physiolibrary.Types.Concentration KR = 0.000671946
        "oxygen dissociation on relaxed(R) hemoglobin subunit";   //*7.875647668393782383419689119171e-5
                                                                //10.500001495896 7.8756465463794e-05

      parameter Physiolibrary.Types.Concentration KT=KR/c
        "oxygen dissociation on tensed(T) hemoglobin subunit";

      parameter Physiolibrary.Types.AmountOfSubstance totalAmountOfHemoglobin=0.001;

      Physiolibrary.Chemical.Components.ChemicalReaction
                                                quaternaryForm(K=L)
        annotation (Placement(transformation(extent={{-2,-56},{18,-36}})));
      Physiolibrary.Chemical.Components.Speciation
                         R0_in_R(numberOfSubunit={4})
        annotation (Placement(transformation(extent={{-38,-48},{-58,-28}})));
      Physiolibrary.Chemical.Components.Speciation
                         T0_in_T(numberOfSubunit={4})
        annotation (Placement(transformation(extent={{78,-48},{58,-28}})));
      Physiolibrary.Chemical.Components.Substance
                          OxyRHm(solute_start=0, Simulation=SimulationType.SteadyState)
        "Oxygenated subunit in R structure of hemoglobin tetramer"
        annotation (Placement(transformation(extent={{-96,6},{-76,26}})));
      Physiolibrary.Chemical.Components.ChemicalReaction
                       oxygenation_R(K=KR, nP=2)
        annotation (Placement(transformation(extent={{-68,6},{-48,26}})));
      Physiolibrary.Chemical.Components.Substance
                          DeoxyRHm(Simulation=SimulationType.SteadyState,
        isDependent=true,
        solute_start=1e-08)
        "Deoxygenated subunit in R structure of hemoglobin tetramer"
        annotation (Placement(transformation(extent={{-38,6},{-18,26}})));
      Physiolibrary.Chemical.Components.Substance
                          OxyTHm(solute_start=0, Simulation=SimulationType.SteadyState)
        "Oxygenated subunit in T structure of hemoglobin tetramer"
        annotation (Placement(transformation(extent={{24,6},{44,26}})));
      Physiolibrary.Chemical.Components.ChemicalReaction
                       oxygenation_T(K=KT, nP=2)
        annotation (Placement(transformation(extent={{52,6},{72,26}})));
      Physiolibrary.Chemical.Components.Substance
                          DeoxyTHm(solute_start=totalAmountOfHemoglobin - 0.00001,
          Simulation=SimulationType.SteadyState)
        "Deoxygenated subunit in T structure of hemoglobin tetramer"
        annotation (Placement(transformation(extent={{80,6},{100,26}})));

      Physiolibrary.Chemical.Components.Substance
                          oxygen_unbound(Simulation=SimulationType.SteadyState, solute_start=0.000001
            *7.875647668393782383419689119171e-5,
        isDependent=true)
        annotation (Placement(transformation(extent={{-2,40},{18,60}})));
      Modelica.Blocks.Sources.Clock clock(offset=1e-06)
        annotation (Placement(transformation(extent={{-96,74},{-76,94}})));
      Modelica.Blocks.Math.Add add annotation (Placement(transformation(
            extent={{-4,-4},{4,4}},
            rotation=270,
            origin={-52,-12})));
      Modelica.Blocks.Math.Add add1 annotation (Placement(transformation(
            extent={{-4,-4},{4,4}},
            rotation=270,
            origin={64,-12})));
      Physiolibrary.SteadyStates.Components.MolarConservationLaw
        hemoglobinConservationLaw(                              n=2,
        Simulation=SimulationType.SteadyState,
        Total(displayUnit="mol") = totalAmountOfHemoglobin)
        annotation (Placement(transformation(extent={{74,-72},{94,-52}})));
      Chemical.Sources.UnlimitedGasStorage O2_in_air(Simulation=Physiolibrary.Types.SimulationType.SteadyState,
        usePartialPressureInput=true,
        T=295.15)   annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=0,
            origin={-58,84})));
      Chemical.Components.GasSolubility gasSolubility(kH_T0=1/(0.0105*(1e-3)*
            Modelica.Constants.R*298.15), useHeatPort=false)
        annotation (Placement(transformation(extent={{-2,62},{18,82}})));
      Modelica.Blocks.Math.Sum oxygen_bound(nin=2)
        annotation (Placement(transformation(extent={{56,-90},{66,-80}})));
      Modelica.Blocks.Math.Division sO2_ "hemoglobin oxygen saturation"
        annotation (Placement(transformation(extent={{88,-94},{98,-84}})));
      Modelica.Blocks.Math.Sum tHb(nin=2)
        annotation (Placement(transformation(extent={{72,-98},{82,-88}})));
    equation

      connect(R0_in_R.species, quaternaryForm.substrates[1])
                                                       annotation (Line(
          points={{-58,-46},{-2,-46}},
          color={107,45,134},
          thickness=1,
          smooth=Smooth.None));
      connect(quaternaryForm.products[1], T0_in_T.species)
                                                     annotation (Line(
          points={{18,-46},{58,-46}},
          color={107,45,134},
          thickness=1,
          smooth=Smooth.None));
      connect(OxyRHm.q_out, oxygenation_R.substrates[1])
                                               annotation (Line(
          points={{-86,16},{-68,16}},
          color={107,45,134},
          thickness=1,
          smooth=Smooth.None));
      connect(oxygenation_R.products[1], DeoxyRHm.q_out)
                                             annotation (Line(
          points={{-48,15.5},{-40,15.5},{-40,16},{-28,16}},
          color={107,45,134},
          thickness=1,
          smooth=Smooth.None));
      connect(OxyTHm.q_out, oxygenation_T.substrates[1])
                                               annotation (Line(
          points={{34,16},{52,16}},
          color={107,45,134},
          thickness=1,
          smooth=Smooth.None));
      connect(oxygenation_T.products[1], DeoxyTHm.q_out)
                                             annotation (Line(
          points={{72,15.5},{82,15.5},{82,16},{90,16}},
          color={107,45,134},
          thickness=1,
          smooth=Smooth.None));
      connect(DeoxyRHm.q_out, R0_in_R.subunitSpecies[1])
                                                   annotation (Line(
          points={{-28,16},{-48,16},{-48,-28}},
          color={107,45,134},
          thickness=1,
          smooth=Smooth.None));
      connect(T0_in_T.subunitSpecies[1], DeoxyTHm.q_out)
                                                   annotation (Line(
          points={{68,-28},{84,-28},{84,16},{90,16}},
          color={107,45,134},
          thickness=1,
          smooth=Smooth.None));
      connect(oxygenation_R.products[2], oxygen_unbound.q_out) annotation (Line(
          points={{-48,16.5},{-42,16.5},{-42,50},{8,50}},
          color={107,45,134},
          thickness=1,
          smooth=Smooth.None));
      connect(oxygenation_T.products[2], oxygen_unbound.q_out) annotation (Line(
          points={{72,16.5},{78,16.5},{78,50},{8,50}},
          color={107,45,134},
          thickness=1,
          smooth=Smooth.None));
      connect(add.y, R0_in_R.totalSubunitAmount[1])
                                              annotation (Line(
          points={{-52,-16.4},{-52,-38},{-56,-38}},
          color={0,0,127},
          smooth=Smooth.None));

      connect(add1.y, T0_in_T.totalSubunitAmount[1])
                                               annotation (Line(
          points={{64,-16.4},{64,-38},{60,-38}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(OxyTHm.solute, add1.u2) annotation (Line(
          points={{34,6},{34,0},{61.6,0},{61.6,-7.2}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(add1.u1, DeoxyTHm.solute) annotation (Line(
          points={{66.4,-7.2},{66.4,0},{90,0},{90,6}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(DeoxyRHm.solute, add.u1) annotation (Line(
          points={{-28,6},{-28,-2},{-49.6,-2},{-49.6,-7.2}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(OxyRHm.solute, add.u2) annotation (Line(
          points={{-86,6},{-86,-2},{-54.4,-2},{-54.4,-7.2}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(add.y, hemoglobinConservationLaw.fragment[1]) annotation (Line(
          points={{-52,-16.4},{-52,-18},{34,-18},{34,-67},{74,-67}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(add1.y, hemoglobinConservationLaw.fragment[2]) annotation (Line(
          points={{64,-16.4},{64,-20},{38,-20},{38,-65},{74,-65}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(oxygen_unbound.q_out,gasSolubility. q_in) annotation (Line(
          points={{8,50},{8,64}},
          color={107,45,134},
          thickness=1,
          smooth=Smooth.None));
      connect(O2_in_air.q_out,gasSolubility. q_out) annotation (Line(
          points={{-48,84},{8,84},{8,82}},
          color={107,45,134},
          thickness=1,
          smooth=Smooth.None));
      connect(clock.y, O2_in_air.partialPressure) annotation (Line(
          points={{-75,84},{-68,84}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(oxygen_bound.y,sO2_. u1) annotation (Line(
          points={{66.5,-85},{84,-85},{84,-86},{87,-86}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(sO2_.u2,tHb. y) annotation (Line(
          points={{87,-92},{84,-92},{84,-93},{82.5,-93}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(OxyTHm.solute, oxygen_bound.u[2]) annotation (Line(
          points={{34,6},{36,6},{36,-84.5},{55,-84.5}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(add.y, tHb.u[1]) annotation (Line(
          points={{-52,-16.4},{-52,-18},{34,-18},{34,-93.5},{71,-93.5}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(OxyRHm.solute, oxygen_bound.u[1]) annotation (Line(
          points={{-86,6},{-86,-85.5},{55,-85.5}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(add1.y, tHb.u[2]) annotation (Line(
          points={{64,-16.4},{64,-20},{38,-20},{38,-92.5},{71,-92.5}},
          color={0,0,127},
          smooth=Smooth.None));
      annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics),
        experiment(StopTime=10000),
        __Dymola_experimentSetupOutput,
        Documentation(revisions="<html>
<p><i>2013</i></p>
<p>Marek Matejak, Charles University, Prague, Czech Republic </p>
</html>"));
    end Allosteric_Hemoglobin2_MWC;

    model CardiovascularSystem_GCG_SteadyState
      "Cardiovascular part of Guyton-Coleman-Granger's model from 1972"
       //extends Modelica.Icons.Example;
       extends Hydraulic.Examples.CardiovascularSystem_GCG(
        pulmonaryArteries(Simulation=Physiolibrary.Types.SimulationType.SteadyState),
        pulmonaryVeins(Simulation=Physiolibrary.Types.SimulationType.SteadyState),
        rightAtrium(Simulation=Physiolibrary.Types.SimulationType.SteadyState),
        arteries(Simulation=Physiolibrary.Types.SimulationType.SteadyState),
        veins(Simulation=Physiolibrary.Types.SimulationType.SteadyState,
            isDependent=true));

       import Physiolibrary.Types.*;

       Components.MassConservationLaw bloodVolume(
        n=5,
        Simulation=Types.SimulationType.SteadyState,
        Total=0.005)
        annotation (Placement(transformation(extent={{68,-14},{88,6}})));
    equation
       connect(pulmonaryArteries.volume, bloodVolume.fragment[4]) annotation (
          Line(
          points={{-52,74},{-52,68},{54,68},{54,-7.2},{68,-7.2}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(pulmonaryVeins.volume, bloodVolume.fragment[5]) annotation (Line(
          points={{14,74},{14,70},{56,70},{56,-6.4},{68,-6.4}},
          color={0,0,127},
          smooth=Smooth.None));
       connect(rightAtrium.volume, bloodVolume.fragment[1]) annotation (Line(
          points={{-72,8},{-72,-72},{56,-72},{56,-9.6},{68,-9.6}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(veins.volume, bloodVolume.fragment[2]) annotation (Line(
          points={{-54,-46},{-54,-70},{54,-70},{54,-8.8},{68,-8.8}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(arteries.volume, bloodVolume.fragment[3]) annotation (Line(
          points={{24,-46},{24,-68},{52,-68},{52,-8},{68,-8}},
          color={0,0,127},
          smooth=Smooth.None));
       annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics), Documentation(info="<html>
<p>Cardiovascular subsystem in famous Guyton-Coleman-Granger model from 1972. </p>
<p><br/>Model, all parameters and all initial values are from article: </p>
<p>A.C. Guyton, T.G. Coleman, H.J. Granger (1972). &QUOT;Circulation: overall regulation.&QUOT; Annual review of physiology 34(1): 13-44.</p>
</html>", revisions="<html>
<p><i>2014</i></p>
<p>Marek Matejak, Charles University, Prague, Czech Republic </p>
</html>"));
    end CardiovascularSystem_GCG_SteadyState;

    model ThermalBody_QHP_STeadyState
      extends Thermal.Examples.ThermalBody_QHP(
        skin(Simulation=Physiolibrary.Types.SimulationType.SteadyState),
        skeletalMuscle(Simulation=Physiolibrary.Types.SimulationType.SteadyState,
            isDependent=true),
        core(Simulation=Physiolibrary.Types.SimulationType.SteadyState),
        GILumen(Simulation=Physiolibrary.Types.SimulationType.SteadyState));

      Components.EnergyConservationLaw energyConservationLaw(
        n=4,
        Simulation=Physiolibrary.Types.SimulationType.SteadyState,
        useTotalInput=false,
        Total=-8373.6)
        annotation (Placement(transformation(extent={{70,-90},{90,-70}})));
    equation
      connect(core.relativeHeat, energyConservationLaw.fragment[1])
                                                              annotation (Line(
          points={{-2,-4},{-2,-85.5},{70,-85.5}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(skin.relativeHeat, energyConservationLaw.fragment[2])
                                                              annotation (Line(
          points={{-58,4},{-58,-84.5},{70,-84.5}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(skeletalMuscle.relativeHeat, energyConservationLaw.fragment[3])
                                                                        annotation (
         Line(
          points={{46,42},{46,-12},{94,-12},{94,-64},{58,-64},{58,-83.5},{70,-83.5}},
          color={0,0,127},
          smooth=Smooth.None));

      connect(GILumen.relativeHeat, energyConservationLaw.fragment[4])
                                                                 annotation (Line(
          points={{50,-52},{52,-52},{52,-82.5},{70,-82.5}},
          color={0,0,127},
          smooth=Smooth.None));
      annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics));
    end ThermalBody_QHP_STeadyState;

    model Cells_SteadyState
     extends Osmotic.Examples.Cell(
        cells(Simulation=Physiolibrary.Types.SimulationType.SteadyState,
            isDependent=true),
        interstitium(Simulation=Physiolibrary.Types.SimulationType.SteadyState),
        interstitium1(Simulation=Physiolibrary.Types.SimulationType.SteadyState),
        cells1(Simulation=Physiolibrary.Types.SimulationType.SteadyState,
            isDependent=true));
      Components.MassConservationLaw waterConservationLaw(
        n=2,
        Simulation=Physiolibrary.Types.SimulationType.SteadyState,
        Total(displayUnit="l") = 0.002)
        annotation (Placement(transformation(extent={{72,14},{92,34}})));
      Components.MassConservationLaw waterConservationLaw1(
        n=2,
        Simulation=Physiolibrary.Types.SimulationType.SteadyState,
        Total(displayUnit="l") = 0.002)
        annotation (Placement(transformation(extent={{70,-92},{90,-72}})));
    equation

      connect(cells.volume, waterConservationLaw.fragment[1])
                                                         annotation (Line(
          points={{-34,36},{-34,19},{72,19}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(interstitium.volume, waterConservationLaw.fragment[2])
                                                                annotation (Line(
          points={{44,36},{44,21},{72,21}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(cells1.volume, waterConservationLaw1.fragment[1])
                                                           annotation (Line(
          points={{-34,-64},{-34,-87},{70,-87}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(interstitium1.volume, waterConservationLaw1.fragment[2])
                                                                  annotation (Line(
          points={{44,-64},{44,-85},{70,-85}},
          color={0,0,127},
          smooth=Smooth.None));
      annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics));
    end Cells_SteadyState;
  end Examples;

  package Components
    extends Modelica.Icons.Package;

    model EnergyConservationLaw "System Energy conservation law"
      extends Interfaces.SteadyStateSystem; //(Simulation=Types.SimulationType.SteadyState);
      extends Physiolibrary.Icons.ConservationLaw;

      parameter Integer n "Number of mass/energy fragments";

      Physiolibrary.Types.RealIO.EnergyInput fragment[n] "Mass/Energy fragment"
        annotation (Placement(transformation(extent={{-120,-60},{-80,-20}}),
            iconTransformation(extent={{-120,-60},{-80,-20}})));

      parameter Boolean useTotalInput = false
        "=true, if total mass/energy is used as an input"
        annotation(Evaluate=true, HideResult=true, choices(__Dymola_checkBox=true),Dialog(group="External inputs/outputs"));

      parameter Physiolibrary.Types.Energy Total
        "Total mass/energy if useTotalAsInput=false"
        annotation (Dialog(enable=not useTotalInput));

      Types.RealIO.EnergyInput total(start=Total) = t if useTotalInput annotation (Placement(transformation(
            extent={{-20,-20},{20,20}},
            rotation=270,
            origin={0,80})));

      Physiolibrary.Types.Energy t "Current Mass/Energy";
    equation
      if not useTotalInput then
        t=Total;
      end if;

      t*normalizedState[1] = sum(fragment);

      //fragment[1] = homotopy( actual=Total*normalizedState[1] - sum(fragment[i] for i in 2:n), simplified=Total*normalizedState[1]*firstFragmentFraction);

      annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
                {100,100}}), graphics={Text(
              extent={{-160,-110},{160,-140}},
              lineColor={0,0,255},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid,
              textString="%name")}), Diagram(coordinateSystem(preserveAspectRatio=false,
              extent={{-100,-100},{100,100}}), graphics),
        Documentation(info="<html>
<p>This block was design to be used instead of obcure inheritance from SteadyState.Interfaces.SteadyStateSystem, but for unknown reason it does not work in OpenModelica 1.9.0 nor in Dymola 2014 for more complex models in steady state. </p>
</html>"));
    end EnergyConservationLaw;

    model MassConservationLaw
      "System Mass (incompresible volume) conservation law"
      extends Interfaces.SteadyStateSystem; //(Simulation=Types.SimulationType.SteadyState);
      extends Physiolibrary.Icons.ConservationLaw;

      parameter Integer n "Number of mass/energy fragments";

      Physiolibrary.Types.RealIO.VolumeInput fragment[n] "Mass/Energy fragment"
        annotation (Placement(transformation(extent={{-120,-60},{-80,-20}}),
            iconTransformation(extent={{-120,-60},{-80,-20}})));

      parameter Boolean useTotalInput = false
        "=true, if total mass/energy is used as an input"
        annotation(Evaluate=true, HideResult=true, choices(__Dymola_checkBox=true),Dialog(group="External inputs/outputs"));

      parameter Physiolibrary.Types.Volume Total
        "Total mass/energy if useTotalAsInput=false"
        annotation (Dialog(enable=not useTotalInput));

      Types.RealIO.VolumeInput total(start=Total) = t if useTotalInput annotation (Placement(transformation(
            extent={{-20,-20},{20,20}},
            rotation=270,
            origin={0,80})));

      Physiolibrary.Types.Volume t "Current Mass/Energy";
    equation
      if not useTotalInput then
        t=Total;
      end if;

      t*normalizedState[1] = sum(fragment);

      //fragment[1] = homotopy( actual=Total*normalizedState[1] - sum(fragment[i] for i in 2:n), simplified=Total*normalizedState[1]*firstFragmentFraction);

      annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
                {100,100}}), graphics={Text(
              extent={{-160,-110},{160,-140}},
              lineColor={0,0,255},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid,
              textString="%name")}), Diagram(coordinateSystem(preserveAspectRatio=false,
              extent={{-100,-100},{100,100}}), graphics),
        Documentation(info="<html>
<p>This block was design to be used instead of obcure inheritance from SteadyState.Interfaces.SteadyStateSystem, but for unknown reason it does not work in OpenModelica 1.9.0 nor in Dymola 2014 for more complex models in steady state. </p>
</html>"));
    end MassConservationLaw;

    model MolarConservationLaw
      "System Amount of substance (=number of molecules) conservation law"
      extends Interfaces.SteadyStateSystem; //(Simulation=Types.SimulationType.SteadyState);
      extends Physiolibrary.Icons.ConservationLaw;

      parameter Integer n "Number of mass/energy fragments";

      Physiolibrary.Types.RealIO.AmountOfSubstanceInput fragment[n]
        "Mass/Energy fragment"
        annotation (Placement(transformation(extent={{-120,-60},{-80,-20}}),
            iconTransformation(extent={{-120,-60},{-80,-20}})));

      parameter Boolean useTotalInput = false
        "=true, if total mass/energy is used as an input"
        annotation(Evaluate=true, HideResult=true, choices(__Dymola_checkBox=true),Dialog(group="External inputs/outputs"));

      parameter Physiolibrary.Types.AmountOfSubstance Total
        "Total mass/energy if useTotalAsInput=false"
        annotation (Dialog(enable=not useTotalInput));

      Types.RealIO.AmountOfSubstanceInput total(start=Total) = t if useTotalInput annotation (Placement(transformation(
            extent={{-20,-20},{20,20}},
            rotation=270,
            origin={0,80})));

      Physiolibrary.Types.AmountOfSubstance t "Current Mass/Energy";
    equation
      if not useTotalInput then
        t=Total;
      end if;

      t*normalizedState[1] = sum(fragment);

      //fragment[1] = homotopy( actual=Total*normalizedState[1] - sum(fragment[i] for i in 2:n), simplified=Total*normalizedState[1]*firstFragmentFraction);

      annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
                {100,100}}), graphics={Text(
              extent={{-160,-110},{160,-140}},
              lineColor={0,0,255},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid,
              textString="%name")}), Diagram(coordinateSystem(preserveAspectRatio=false,
              extent={{-100,-100},{100,100}}), graphics),
        Documentation(info="<html>
<p>This block was design to be used instead of obcure inheritance from SteadyState.Interfaces.SteadyStateSystem, but for unknown reason it does not work in OpenModelica 1.9.0 nor in Dymola 2014 for more complex models in steady state. </p>
</html>"));
    end MolarConservationLaw;
  end Components;

  package Interfaces
    extends Modelica.Icons.InterfacesPackage;

    partial model SteadyState
      "Abstract class for any dynamic state calculation (for any derivation), which is driven by SimulationType option."
      //allow to switch between dynamic mode 'der(y)=x' and steady-state mode 'der(y)=0'
      import Physiolibrary.Types.*;

      replaceable package Utilities = Physiolibrary.Types.FilesUtilities
                                                                      constrainedby
        Physiolibrary.Types.Utilities
                     annotation (Dialog(group="Functions to read or store",tab="IO"));

      Real state(start=state_start, stateSelect=StateSelect.prefer)
        "This state must be connected in inherited class definition";

      Real change "Dynamic change of state value per minute";

      parameter Real state_start "State start or init value"
       annotation (Dialog(enable=false,group="Initialization", tab="IO"));

      parameter SimulationType  Simulation(start=SimulationType.NormalInit)
        "Dynamic with Initialization or Steady State"
        annotation (Dialog(group="Simulation",tab="Equilibrium"));

      parameter Boolean SAVE_RESULTS = false
        "save and test final state values with original values"
         annotation (Dialog(group="Value I/O",tab="IO"));

      parameter String storeUnit="" "Unit in Utilities input/output function"
         annotation (Dialog(group="Value I/O",tab="IO"));

      parameter String stateName="" "Name in Utilities input/output function"
         annotation (Dialog(group="Value I/O",tab="IO"));
                                    //getInstanceName()

      parameter Boolean isDependent = false
        "=true, If zero flow is propagated in eqiulibrium through resistors, impedances, reactions, etc."
        annotation (Dialog(group="Simulation",tab="Equilibrium"));

    protected
      parameter Real defaultValue(fixed=false) "Default value of state.";
      parameter Real initialValue(fixed=false) "Initial value of state.";

    initial equation

      if Simulation == SimulationType.NormalInit then
        state = state_start;
      elseif Simulation == SimulationType.ReadInit then
        state = Utilities.readReal(stateName, storeUnit);
      elseif Simulation == SimulationType.InitSteadyState and not isDependent then
        der(state)=0;  //here it have the same meaning as "change = 0", because of equation "der(state) = change"
      end if;

      initialValue = state; //in causality such as initialValue:=state
      if SAVE_RESULTS then
        defaultValue = Utilities.readReal(stateName, storeUnit);
      else
        defaultValue = Modelica.Constants.N_A;
      end if;
    equation

      when SAVE_RESULTS and terminal() then
        Utilities.writeReal(
            stateName,
            state,
            storeUnit);
        Utilities.writeComparison(
            stateName,
            defaultValue,
            initialValue,
            state,
            storeUnit);
      end when;

      if Simulation <> SimulationType.SteadyState then
        der(state) = change;
      elseif not isDependent then   /*** this test and equation exclusion could be done automatically, if the solver will be so smart that it removes all this dependend equations from the total equilibrated system. The most probable form of this dependent equation in equilibrium setting is (0 = 0). ***/
         change = 0;
      end if;

      annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics),Documentation(revisions="<html>
<p><i>2013</i></p>
<p>Marek Matejak, Charles University, Prague, Czech Republic </p>
</html>"));
    end SteadyState;

    partial model SteadyStates
      "Abstract class for any dynamic states calculation (for any derivations), which is driven by SimulationType option."
      //allow to switch between dynamic mode 'der(y)=x' and steady-state mode 'der(y)=0'
      import Physiolibrary.Types.*;

      replaceable package Utilities = Physiolibrary.Types.FilesUtilities
                                                                      constrainedby
        Physiolibrary.Types.Utilities
                     annotation (Dialog(group="Functions to read or store",tab="IO"));

      parameter Integer n "Number of states"
        annotation (Dialog(group="Simulation"));

      Real state[n](start=state_start, stateSelect=StateSelect.prefer)
        "This state must be connected in inherited class definition";

      Real change[n] "Dynamic change of state value per minute";

      parameter Real state_start[n] "State start or init value"
       annotation (Dialog(enable=false,group="Initialization", tab="IO"));

      parameter SimulationType  Simulation(start=SimulationType.NormalInit)
        "Dynamic with Initialization or Steady State"
        annotation (Dialog(group="Simulation",tab="Equilibrium"));

      parameter Boolean SAVE_RESULTS = false
        "save and test final state values with original values"
         annotation (Dialog(group="Value I/O",tab="IO"));

      parameter String storeUnit[n]=fill("",n)
        "Unit in Utilities input/output function"
         annotation (Dialog(group="Value I/O",tab="IO"));

      parameter String stateName[n]=fill("",n)
        "Name in Utilities input/output function"
         annotation (Dialog(group="Value I/O",tab="IO"));
                                    //getInstanceName()

      parameter Boolean isDependent[n]= fill(false,n)
        "=true, If zero flow is propagated in eqiulibrium through resistors, impedances, reactions, etc."
        annotation (Dialog(group="Simulation",tab="Equilibrium"));

    protected
      parameter Real defaultValue[n](fixed=false) "Default value of state.";
      parameter Real initialValue[n](fixed=false) "Initial value of state.";

    initial equation
      for i in 1:n loop
      if Simulation == SimulationType.NormalInit then
        state[i] = state_start[i];
      elseif Simulation == SimulationType.ReadInit then
          state[i] = Utilities.readReal(stateName[i], storeUnit[i]);
      elseif Simulation == SimulationType.InitSteadyState and not isDependent[i] then
        der(state[i])=0;  //here it have the same meaning as "change = 0", because of equation "der(state) = change"
      end if;

      initialValue = state; //in causality such as initialValue:=state
      if SAVE_RESULTS then
        defaultValue[i] = Utilities.readReal(stateName[i], storeUnit[i]);
      else
        defaultValue[i] = Modelica.Constants.N_A;
      end if;
      end for;
    equation

      when SAVE_RESULTS and terminal() then
        for i in 1:n loop
        Utilities.writeReal(
            stateName[i],
            state[i],
            storeUnit[i]);
        Utilities.writeComparison(
            stateName[i],
            defaultValue[i],
            initialValue[i],
            state[i],
            storeUnit[i]);
        end for;
      end when;

      if Simulation <> SimulationType.SteadyState then
        der(state) = change;
      else
        for i in 1:n loop
          if not isDependent[n] then   /*** this test and equation exclusion could be done automatically, if the solver will be so smart that it removes all this dependend equations from the total equilibrated system. The most probable form of this dependent equation in equilibrium setting is (0 = 0). ***/
            change[i] = 0;
          end if;
        end for;
      end if;

      annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics),Documentation(revisions="<html>
<p><i>2013</i></p>
<p>Marek Matejak, Charles University, Prague, Czech Republic </p>
</html>"));
    end SteadyStates;

    partial class SteadyStateSystem
      "Global abstract class, for additional global state equations"

      import Physiolibrary.Types.*;

      parameter SimulationType  Simulation(start=SimulationType.NormalInit)
        "Dynamic with Initialization or Steady State"
        annotation (Dialog(group="Simulation type", tab="Simulation"));

      parameter Integer NumberOfDependentStates=1
        "Number of additional steady state equation of the system"
      annotation (Dialog(enable=false,group="Equilibrium", tab="Simulation"));

      Real normalizedState[NumberOfDependentStates]
        "Normalized independent masses of the system/Normalized independent energies of the system/... This variables must always equals to ones.";

    protected
      Real state[NumberOfDependentStates](each start=1)
        "In differential systems has the same meaning as the normalizedState. In steady state has no meaning.";

    initial equation

      state=ones(NumberOfDependentStates);

    equation

      if Simulation == SimulationType.SteadyState then
        normalizedState = ones(NumberOfDependentStates); //add additional global steady-state equations
        der(state)=zeros(NumberOfDependentStates);       //remove 'state' from system calculations
      else
        normalizedState = state; //nothing special, just definition of 'state' variable

        //Correct definition of normalizedState should fulfill the equation 'normalizedState=ones(NumberOfDependentStates)' during simulation.
        //The difference from vector 'ones(NumberOfDependentStates)' could be used as the solver calculation error vector.
      end if;

      annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics), Documentation(revisions="<html>
<p><i>2013-2014</i></p>
<p>Marek Matejak, Charles University, Prague, Czech Republic </p>
</html>"));
    end SteadyStateSystem;
  end Interfaces;
  annotation (Documentation(revisions="<html>
<p>Licensed by Marek Matejak under the Modelica License 2</p>
<p>Copyright &copy; 2008-2013, Marek Matejak, Charles University in Prague.</p>
<p><br/><i>This Modelica package is&nbsp;<u>free</u>&nbsp;software and the use is completely at&nbsp;<u>your own risk</u>; it can be redistributed and/or modified under the terms of the Modelica License 2. For license conditions (including the disclaimer of warranty) see&nbsp;<a href=\"modelica://Physiolibrary.UsersGuide.ModelicaLicense2\">Physiolibrary.UsersGuide.ModelicaLicense2</a>&nbsp;or visit&nbsp;<a href=\"http://www.modelica.org/licenses/ModelicaLicense2\">http://www.modelica.org/licenses/ModelicaLicense2</a>.</i></p>
</html>", info="<html>
<p>One of the main question in clinical medicine is how to stabilize the patient. In the fact of the oscillating heart, breathing, circadian rhythm or menstruation cycle the model could be designed as non-oscillating with variables such as period times, amplitudes, frequencies, mean values and other phase space variables. This type of model has better numerical stability for longer simulation time and even more it can be &QUOT;stabilized&QUOT;. This stabilization we called steady state. </p>
<p>To be mathematically exact, we define an <i><b>steady state system</b></i> (SSS) as a non-differential system derived from a original differential system (DS) by using zero derivations and by adding <b>additional steady state equations</b> (ASSE). The number of the ASSE must be the same as the number of algebraically dependent equations in the non-differential system derived from DS by setting zero derivations. The ASSE describes the system from the top view mostly such as the equations of mass conservation laws or the boundary equation of environment sources. To define a model as an SSS the user must switch each Simulation parameter in each block to value Types.SimulationType.SteadyState and must have correctly defined all necessary ASSE. This setting caused to ignoring any start values for any state and add zero derivation equations instead. Today does not exist Modelica environment, which could automatically find and remove generated dependent equations by this way. So the correct number of states must be marked as dependent (parameter isDependent) and the same number of ASSE must be inserted. Despite the fact, that model in this steady-state setting will be not locally balanced it should be globally balanced and without any dependent equation.</p>
<p>Adding of one ASSE is possible by inserting and connecting of the energy or mass conservation law block from package SteadyState.Components. Other possibilities is in blocks of environment&nbsp; sources, where the setting of parameter isIsolatedInSteadyState&nbsp; add the equation of the zero mass/volume/energy flow from or to environment. </p>
<p>The model in steady state often changes to one big nonlinear strong component, but without solver stiff or convergence problems. Especially in quick chemical reaction kinetics is not necessary to have very rapid molar fluxes, when it always reach equilibrium. This design also approve to create steady stated parts in dynamical model without huge rebuilding. It also&nbsp; brings other benefits. To see these possibilities, one have to realize that conservation laws could be invariances in a dynamical simulation. This is really useful for debugging. </p>
<p>It is always a big challenge to nicely solve initial values of differential system. However, it should be possible to solve the SSS in initial phase. And this is the idea behind the Types.SimulationTypes.InitSteadyState option for models already extended with ASSE to support SSS. </p>
</html>"));
end SteadyStates;
