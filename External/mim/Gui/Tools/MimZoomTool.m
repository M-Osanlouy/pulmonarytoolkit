classdef MimZoomTool < MimTool
    % MimZoomTool. A tool for interactively zooming an image with MimViewerPanel
    %
    %     MimZoomTool is a tool class used with MimViewerPanel to allow the user
    %     to zoom an image using mouse and keyboard controls.
    %
    %
    %     Licence
    %     -------
    %     Part of the TD MIM Toolkit. https://github.com/tomdoel
    %     Author: Tom Doel, 2013.  www.tomdoel.com
    %     Distributed under the MIT licence. Please see website for details.
    %
        
    properties
        ButtonText = 'Zoom'
        Cursor = 'circle'
        ToolTip = 'Zoom tool'
        Tag = 'Zoom'
        ShortcutKey = ''
    end
    
    properties (Access = private)
        Callback
    end    
    
    methods
        function obj = MimZoomTool(callback)
            obj.Callback = callback;
        end
        
        function MouseDragged(obj, screen_coords, last_coords)
            [min_coords, max_coords] = obj.Callback.GetImageLimits;
            x_range = max_coords(1) - min_coords(1);
            y_range = max_coords(2) - min_coords(2);
            
            coords_offset = screen_coords - last_coords;
            
            y_relative_movement = coords_offset(2)/y_range;
            
            relative_scale = y_relative_movement;
            x_range_scale = relative_scale*x_range/1;
            y_range_scale = relative_scale*y_range/1;
            
            x_lim = [min_coords(1) - x_range_scale, max_coords(1) + x_range_scale];
            
            y_lim = [min_coords(2) - y_range_scale, max_coords(2) + y_range_scale];
            
            if (abs(x_lim(2) - x_lim(1)) > 10) && (abs(y_lim(2) - y_lim(1)) > 10) && ...
                    (abs(x_lim(2) - x_lim(1)) < 1000) && (abs(y_lim(2) - y_lim(1)) < 800)
                obj.Callback.SetImageLimits([x_lim(1), y_lim(1)], [x_lim(2), y_lim(2)]);
            end
        end
    end
end

