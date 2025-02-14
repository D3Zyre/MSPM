%{
   Modular Single Phase Model - MSPM. A program for simulating single phase cyclical thermodynamic machines.
   Copyright (C) 2023  David Nobes
      Mailing Address:
         University of Alberta
         Mechanical Engineering
         10-281 Donadeo Innovation Centre For Engineering
         9211-116 St
         Edmonton
         AB
         T6G 2H5
      Email: dnobes@ualberta.ca

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <https://www.gnu.org/licenses/>.
%}

classdef Environment < handle
    % models the Environment, which is everything that isn't defined by the user,
    % in other words, everywhere where there isn't a body.
    % contains a pressure, temperature, material, node, group

    properties (Constant)
        StdPressure = 101325; % Pa
        StdTemperature = 298; % K
        Stdh = 20; % W/m*K
        StdGas = 'AIR';
    end

    properties
        Pressure double;
        Temperature double;
        h double;
        matl Material;
        nodeIndex double;
        name char;

        GUIObjects = [];

        isDiscretized logical = false;
        Node Node;
    end

    properties (Dependent)
        Group
    end

    methods
        %% Constructor
        function this = Environment(Pressure,Temperature,h,MaterialRef)
            switch nargin
                case 0
                    this.Pressure = Environment.StdPressure;
                    this.Temperature = Environment.StdTemperature;
                    this.h = Environment.Stdh;
                    this.matl = Material(Environment.StdGas);
                    this.name = 'Standard AIR Environment';
                case 1
                    this.Pressure = Pressure;
                    this.Temperature = Environment.StdTemperature;
                    this.h = Environment.Stdh;
                    this.matl = Material(Environment.StdGas);
                    this.name = 'Untitled Environment';
                case 2
                    this.Pressure = Pressure;
                    this.Temperature = Temperature;
                    this.h = Environment.Stdh;
                    this.matl = Material(Environment.StdGas);
                    this.name = 'Untitled Environment';
                case 3
                    this.Pressure = Pressure;
                    this.Temperature = Temperature;
                    this.h = h;
                    this.matl = Material(Environment.StdGas);
                    this.name = 'Untitled Environment';
                case 4
                    this.Pressure = Pressure;
                    this.Temperature = Temperature;
                    this.h = h;
                    this.matl = MaterialRef;
                    this.name = 'Untitled Environment';
            end
        end

        %% Get/Set Interface
        function Item = get(this,PropertyName)
            switch PropertyName
                case 'Pressure'
                    Item = this.Pressure;
                case 'Temperature'
                    Item = this.Temperature;
                case 'h'
                    Item = this.h;
                case 'Gas'
                    Item = this.matl;
                case 'Name'
                    Item = this.name;
                otherwise
                    fprintf(['XXX Environment GET Inteface for ' PropertyName ' is not found XXX\n']);
            end
        end
        function set(this,PropertyName,Item)
            switch PropertyName
                case 'Pressure'
                    this.Pressure = Item;
                    if this.isDiscretized
                        this.Node.data.Pressure = Item;
                    end
                case 'Temperature'
                    this.Temperature = Item;
                    if this.isDiscretized
                        this.Node.data.Temperature = Item;
                    end
                case 'h'
                    this.h = Item;
                    if this.isDiscretized
                        this.Node.data.h = Item;
                    end
                case 'Name'
                    this.customname = Item;
                otherwise
                    fprintf(['XXX Environment SET Inteface for ' PropertyName ' is not found XXX\n']);
            end
        end

        %% Node Management
        function resetDiscretization(this)
            this.Node(:) = [];
            this.isDiscretized = false;
        end
        function discretize(this)
            this.Node = Node.empty;
            this.Node = Node(enumNType.EN,0,0,0,0,Face.empty,Node.empty,this,0);
            this.isDiscretized = true;
            this.Node.data.Dh = 1e8;
            %         if ~this.isDiscretized
            %           delete(this.Node);
            %           this.Node = Node(enumNType.EN,0,0,0,0,Face.empty,Node.empty,this,0); %#ok<PROP>
            %           this.isDiscretized = true;
            %         end
        end

        %% Graphics
        function removeFromFigure(this,AxisReference)
            if ~isempty(this.GUIObjects)
                children = get(AxisReference,'Children');
                for obj = this.GUIObjects
                    if isgraphics(obj)
                        for i = length(children):-1:1
                            if isgraphics(children(i)) && children(i) == obj
                                children(i).delete;
                                break;
                            end
                        end
                    end
                end
                this.GUIObjects = [];
            end
        end

        function igroup = get.Group(this)
            igroup = Group([],Position(0,0,pi/2),Body.empty);
        end
    end
end

