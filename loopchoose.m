function subhandle = loopchoose(n,k)
% loopchoose: returns the combinations that nchoosek would, but does it iteratively
% usage 1: subhandle = loopchoose(n,k);   Initial call to set up loopchoose
% usage 2: subset = subhandle();        Subsequent calls
%
% LOOPCHOOSE exists for those occasions where nchoosek will overflow
% memory and the combinations can be generated in a loop, one at a time.
% Why use LOOPCHOOSE? Because c = nchoosek(1:20,10) is an array that
% requires 14780480 bytes of memory to store. LOOPCHOOSE can generate
% much larger sets of combinations without incurring a memory overflow.
%
% LOOPCHOOSE is also not that terribly slow. whereas nschoosek(1:20,10)
% had an ellapsed time of 18.350041 seconds on my computer, the
% LOOPCHOOSE loop took less than twice as long, only 32.721433 seconds.
% 
% arguments: (initial call, input)
%   n - scalar integer - size of total set
%
%   k - scalar integer - size of the subsets chosen
%
% arguments: (initial call, output)
%   subhandle - a function handle to a nested function that will
%       return subsequent subsets.
%
%
% arguments: (subsequent calls, input)
%   On subsequent calls to the returned function handle, no input
%   arguments are required. subhandle is a nested function handle.
% 
% arguments: (output)
%   subset - a subset (of length k) of the integers 1:n
%
% 
% Example usage:
%  Generate all subsets of the integers 1:4, taken 2 at a time 
% 
%  subhandle = loopchoose(4,2); % initialization call
%  p = nchoosek(4,2);
%  combos = zeros(p,2);
%  for i = 1:nchoosek(4,2)
%    combos(i,:) = subhandle(); % subsequent calls
%  end
%
%  combos
%  combos =
%
%     1     2
%     1     3
%     1     4
%     2     3
%     2     4
%     3     4
%
%
% See also: nchoosek
%
% Author: John D'Errico
% e-mail: woodchips@rochester.rr.com
% Release: 1.0
% Release date: 12/6/2006

% The initial call to set up the problem

% First, check for errors
if (n<1) || (n~=floor(n))
  error 'n must be a positive integer'
elseif (k>n) || (k<1) || (k~=floor(k))
  error 'k must be a positive integer, k<=n'
end

% set of all possible elements
tset = 1:n;

% Return a function handle to a nested function that does the
% actual work
subhandle = @choosenext;

% This is the current subset. If empty, then this is the first call.
currentsubset = [];

% done until calls to choosenext
return

% ===================================
%   nested function
% ===================================
function subset = choosenext
% called with no arguments, all information is retained
% in the nested function.

if isempty(currentsubset)
  % Initial subset
  subset = 1:k;
else
  % This must be a subsequent call. figure out the next subset.
  
  if currentsubset(1) == (n-k+1)
    % Already returned the last combination in the set.
    subset = [];
    return
  end
  
  % finally, we can get to work
  last = currentsubset(end);
  if last < n
    % we can just increment the last element
    subset = currentsubset;
    subset(end) = last+1;
  else
    % The last element was already maxed.
    d = diff(currentsubset);
    L = find(d>1,1,'last');
    subset = currentsubset;
    subset(L) = subset(L)+1;
    subset(L+1:end) = subset(L) + (1:(k-L));
  end
  
end

% save currentsubset for the next call
currentsubset = subset;

% done with this nested call
end

% mainline end
end

