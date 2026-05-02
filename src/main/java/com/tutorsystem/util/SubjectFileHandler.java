package com.tutorsystem.util;

import com.tutorsystem.model.Subject;
import java.io.*;
import java.util.ArrayList;
import java.util.List;

/**
 * SubjectFileHandler - OOP Concept: ABSTRACTION
 * Hides file read/write complexity behind simple methods
 */
public class SubjectFileHandler {

    private static final String FILE_PATH = "subjects.txt";

    public static List<Subject> readAllSubjects() {
        List<Subject> list = new ArrayList<>();
        File file = new File(FILE_PATH);
        if (!file.exists()) return list;
        try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
            String line;
            while ((line = reader.readLine()) != null) {
                line = line.trim();
                if (!line.isEmpty()) {
                    Subject s = Subject.fromFileString(line);
                    if (s != null) list.add(s);
                }
            }
        } catch (IOException e) {
            System.err.println("Error reading: " + e.getMessage());
        }
        return list;
    }

    private static void writeAllSubjects(List<Subject> list) {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(FILE_PATH, false))) {
            for (Subject s : list) {
                writer.write(s.toFileString());
                writer.newLine();
            }
        } catch (IOException e) {
            System.err.println("Error writing: " + e.getMessage());
        }
    }

    public static boolean addSubject(Subject subject) {
        List<Subject> list = readAllSubjects();
        for (Subject s : list) {
            if (s.getSubjectId().equalsIgnoreCase(subject.getSubjectId())) return false;
        }
        list.add(subject);
        writeAllSubjects(list);
        return true;
    }

    public static Subject findById(String id) {
        for (Subject s : readAllSubjects()) {
            if (s.getSubjectId().equalsIgnoreCase(id)) return s;
        }
        return null;
    }

    public static List<Subject> searchSubjects(String keyword) {
        List<Subject> results = new ArrayList<>();
        String kw = keyword.toLowerCase();
        for (Subject s : readAllSubjects()) {
            if (s.getSubjectName().toLowerCase().contains(kw) ||
                s.getCategory().toLowerCase().contains(kw)    ||
                s.getGradeLevel().toLowerCase().contains(kw)) {
                results.add(s);
            }
        }
        return results;
    }

    public static boolean updateSubject(Subject updated) {
        List<Subject> list = readAllSubjects();
        boolean found = false;
        for (int i = 0; i < list.size(); i++) {
            if (list.get(i).getSubjectId().equalsIgnoreCase(updated.getSubjectId())) {
                list.set(i, updated);
                found = true;
                break;
            }
        }
        if (found) writeAllSubjects(list);
        return found;
    }

    public static boolean deleteSubject(String id) {
        List<Subject> list = readAllSubjects();
        boolean removed = list.removeIf(s -> s.getSubjectId().equalsIgnoreCase(id));
        if (removed) writeAllSubjects(list);
        return removed;
    }

    public static String generateNextId() {
        List<Subject> list = readAllSubjects();
        int max = 0;
        for (Subject s : list) {
            try {
                int num = Integer.parseInt(s.getSubjectId().replace("SUB", ""));
                if (num > max) max = num;
            } catch (NumberFormatException ignored) {}
        }
        return String.format("SUB%03d", max + 1);
    }
}
