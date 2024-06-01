import { IsDateString, IsInt, IsNotEmpty } from 'class-validator';

export class CreatePlanDto {
  @IsNotEmpty()
  @IsDateString()
  startingdate: string;

  @IsNotEmpty()
  @IsDateString()
  duedate: string;

  @IsNotEmpty()
  @IsInt()
  weightGoal: number;

  @IsNotEmpty()
  @IsInt()
  calorieGoal: number;

  @IsNotEmpty()
  @IsInt()
  calorie: number;

  @IsNotEmpty()
  @IsInt()
  weight: number;
}
