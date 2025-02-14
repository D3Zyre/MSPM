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

classdef Line2DChain < handle
    %LINECHAIN Summary of this class goes here
    %   Detailed explanation goes here

    properties
        Pnts Pnt2D = Pnt2D.empty;
    end

    properties (Dependent)
        XData double;
        YData double;
        Start Pnt2D;
        End Pnt2D;
        isFinished logical;
    end

    methods
        function this = Line2DChain(x1,y1,x2,y2)
            if nargin > 0
                this.Pnts = [Pnt2D(x1,y1) Pnt2D(x2,y2)];
            end
        end
        function successful = attemptToMerge(this,other)
            successful = false;
            if this.Pnts(end) == other.Pnts(1)
                this.Pnts = [this.Pnts other.Pnts(2:end)]; successful = true;
            elseif this.Pnts(end) == other.Pnts(end)
                this.Pnts = [this.Pnts other.Pnts(end-1:-1:1)]; successful = true;
            elseif this.Pnts(1) == other.Pnts(end)
                this.Pnts = [other.Pnts this.Pnts(2:end)]; successful = true;
            elseif this.Pnts(1) == other.Pnts(1)
                this.Pnts = [other.Pnts(end:-1:2) this.Pnts]; successful = true;
            end
        end
        function isFinished = get.isFinished(this)
            isFinished = (this.Pnts(1).x == 0 && this.Pnts(end).x == 0) || ...
                (this.Pnts(1) == this.Pnts(end));
        end
        function Start = get.Start(this)
            Start = this.Pnts(1);
        end
        function End = get.End(this)
            End = this.Pnts(end);
        end
        function XData = get.XData(this)
            XData = zeros(1,length(this.Pnts));
            for i = 1:length(this.Pnts)
                XData(i) = this.Pnts(i).x;
            end
        end
        function YData = get.YData(this)
            YData = zeros(1,length(this.Pnts));
            for i = 1:length(this.Pnts)
                YData(i) = this.Pnts(i).y;
            end
        end
    end
end

