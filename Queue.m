classdef Queue < handle %create FIFO queue class
    properties
        qlist = {};
    end
    methods
        function r = empty(self)
            r = isempty(self.qlist);
        end
        
        function r = front(self)
            r = self.qlist{1};
        end
        
        function push(self, obj)
            self.qlist{end + 1} = obj;  
        end
        
        function pop(self)
            self.qlist = self.qlist(2:end);
        end
    end
end
