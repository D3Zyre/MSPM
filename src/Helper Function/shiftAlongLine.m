function adjusted_point = shiftAlongLine(point, A, B, C, para_shift, perp_shift)
    % Function shifts a point along a line specified in the form Ax + By + C = 0
    % Shift distance is a scalar
    % Shift direction is a unit vector [x_shift_direction, y_shift_direction]
    % Given point coordinates

   % Calculate the direction vector along the given line
    line_direction = [-B, A];
    line_direction = line_direction / norm(line_direction);

    % Calculate the shift vector in the original coordinate system
    shift_vector = perp_shift * line_direction + para_shift * [A, B];

    % Calculate the new coordinates of the shifted point
    new_x = point(1) + shift_vector(1);
    new_y = point(2) + shift_vector(2);

    % Convert to a single vector
    adjusted_point = [new_x, new_y];
end