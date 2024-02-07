TARGET="../godot_simple_unit_test"

# Initial Cleanup
rm -rf $TARGET
rm -rf tmp

# Clone the repository into a new directory
git clone --depth=1 -b develop git@github.com:accidentallyc/GodotSimpleUnitTest.git tmp

# Navigate into the new directory
cd tmp

# Get subdir
git sparse-checkout set --no-cone addons/godot_simple_unit_test/src

# Go back to scripts folder
cd ..

mv ./tmp/addons/godot_simple_unit_test/src $TARGET

# Remove the built in GD_
rm -f $TARGET/GD__.gd
rm -f $TARGET/GD__indirect.gd
rm -f $TARGET/GD__base.gd

find  $TARGET -type f -name "*.import" -delete
find $TARGET -type f -name "*.gd" -exec sed -i 's/GD__/GD_/g' {} \;
find $TARGET -type f -name "*.gd" -exec sed -i 's|res://addons/godot_simple_unit_test/src|res://godot_simple_unit_test|g' {} \;
find $TARGET -type f -name "*.tscn" -exec sed -i 's|res://addons/godot_simple_unit_test/src|res://godot_simple_unit_test|g' {} \;



# Remove temporary folder
rm -rf tmp