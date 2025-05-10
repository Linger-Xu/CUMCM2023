% 创建一个示例整数数组
array = [5, 2, 8, 1, 9, 3];

% 使用 sort 函数对数组进行排序，并返回排序后的数组及其对应的索引
[sorted_array, sorted_indices] = sort(array);

% 显示排序后的数组
disp('排序后的数组：');
disp(sorted_array);

% 显示排序后的索引
disp('排序后的索引：');
disp(sorted_indices);

% 创建一个示例数组
array = [2, 4, 6, 2, 8, 6, 10, 12, 8, 14];

% 使用 unique 函数查找唯一值和其索引
[unique_values, ~, index_in_unique] = unique(array);

% 使用 hist 函数计算元素的频次
histogram = hist(index_in_unique, 1:numel(unique_values));

% 找到重复数据的索引
repeated_indices = find(histogram > 1);

% 显示重复数据的索引
disp('重复数据的索引：');
disp(repeated_indices);


